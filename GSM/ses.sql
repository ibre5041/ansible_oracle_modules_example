
col GLOBAL_NAME for a16
col DB_UNIQUE_NAME for a16
col HOST_NAME for a20
col SERVICE_NAME for a40
col CLIENT_IDENTIFIER for a40
col PDB_NAME for a10

SELECT g.global_name,
       d.db_unique_name,
       d.database_role,
       i.host_name,
       SYS_CONTEXT('USERENV','CON_NAME')     AS pdb_name,
       SYS_CONTEXT('USERENV','SERVICE_NAME') AS service_name,
       SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER') AS client_identifier
FROM   global_name g,
       v$database d,
       v$instance i;
       
