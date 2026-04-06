
all:
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9d-26-restart.inventory.yml --skip oracledb
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9e-26-restart.inventory.yml --skip oracledb
	ansible-playbook install_gsm.yml -i gsm-emea.yml
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml --extra-vars oracle_sid=EMEA
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml --extra-vars oracle_sid=APAC

db:
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml --extra-vars oracle_sid=EMEA
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml --extra-vars oracle_sid=APAC

shard:
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml --extra-vars oracle_sid=EMEA
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml --extra-vars oracle_sid=APAC

clean_db:
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=CATALOG --tags dbca
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=EMEA --tags dbca
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=APAC --tags dbca
