## Create Database servers:

    ansible-playbook install_oracle_crs_26ai.yml -i ./rhel9de-26-rac.inventory.yml --skip oracledba
    ansible-playbook install_oracle_crs_26ai.yml -i ./rhel9fg-26-rac.inventory.yml --skip oracledba

## Create Databases:

    ansible-playbook emea_26ai.yml -i ./rhel9de-26-rac.inventory.yml
    ansible-playbook cat_26ai.yml -i  ./rhel9de-26-rac.inventory.yml
    
    ansible-playbook apac_26ai.yml -i ./rhel9fg-26-rac.inventory.yml

## RMAN Clone and APAC DB and DG

In EMEA:

- Start APAC database in nomount

    export ORACLE_SID=APAC
    sqlplus / as sysdba
    startup nomount pfile='/home/oracle/initAPAC.ora'

- Configure Listener statuc registration for APAC database

    /oracle/u01/gi/23.26.1.0.0/network/admin/listener.ora
    SID_LIST_LISTENER_APAC=(SID_LIST=(SID_DESC=(ORACLE_HOME=/oracle/u01/product/23.26.1.0.0)(SID_NAME=APAC)(SERVICE_NAME=APAC_AT_EMEA)))
    
    X-+ASM
    lsnrctl stop LISTENER_APAC
    lsnrctl start LISTENER_APAC
    lsnrctl services LISTENER_APAC

- Check wallet connection

    sqlplus sys/@EMEA_AT_EMEA as sysdba
    sqlplus sys/@APAC_AT_APAC as sysdba

- Duplicate database

    rman target /@APAC_AT_APAC auxiliary sys/AcrorA123456__@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=gsm-shard-emea)(PORT=1531))(CONNECT_DATA=(SID=APAC)(UR=A)))
    RMAN> @apac_duplicate.rman

- Register DB CRS

    srvctl add database -db APAC_AT_EMEA \
       -oraclehome /oracle/u01/product/23.26.1.0.0 \
       -dbname APAC \
       -instance APAC \
       -spfile '+XDATA/APAC_AT_EMEA/spfileAPAC_AT_EMEA.ora' \
       -startoption 'MOUNT' \
       -stopoption IMMEDIATE
    srvctl status database -thishome
    srvctl start database -d APAC_AT_EMEA -startoption mount
    SQL> alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=gsm-shard-emea)(PORT=1531))' scope=both;

- DG Config

    DGMGRL> connect /@APAC_AT_APAC
    DGMGRL> CREATE CONFIGURATION APAC AS PRIMARY DATABASE IS APAC_AT_APAC CONNECT IDENTIFIER IS APAC_AT_APAC; 
    DGMGRL> ADD DATABASE APAC_AT_EMEA AS CONNECT IDENTIFIER IS APAC_AT_EMEA;
    DGMGRL> enable configuration;
    DGMGRL> switchover to apac_at_emea;
    DGMGRL> switchover to apac_at_apac;

    DGMGRL> enable fast_start failover;
    Warning: ORA-16827: Flashback Database is disabled.

    srvctl modify database -d APAC_AT_EMEA -startoption 'READ ONLY'

- You need to:
  - check short vs. long hostname (for GSM you need full FQDN)
    - select host_name from v$instance
    - hostname
    - show paramete local_listener
    - tnsnames.ora, listener record
    - listener.ora, listener record
  - ON standby side, there is not w/o for PDB save state
    - Open PDB manually or:
    - The one built-in 26ai path that does manage PDB state at the standby side is DG PDB broker management, not a regular physical standby CDB. In that model, Oracle documents DGMGRL EDIT PLUGGABLE DATABASE <pdb> AT <db_unique_name> SET STATE = APPLY-ON|APPLY-OFF, and the broker can explicitly change standby PDB state.
    - Use database trigger to OPEN PDB on standby side

  - Switchover APAC database to APAC
  - Check whether STANDBY database is in Flashback mode
  
    