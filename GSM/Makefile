
all:
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9d-26-restart.inventory.yml --skip oracledb
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9e-26-restart.inventory.yml --skip oracledb
	ansible-playbook listeners.yml -i rhel9d-26-restart.inventory.yml -i rhel9e-26-restart.inventory.yml
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531

db:
	ansible-playbook cat_26ai.yml -i rhel9d-26-restart.inventory.yml
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531

shard:
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530 --tags=wallet
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml -e oracle_sid=APAC -e shard_listener_port-1531 --tags=wallet

clean_db:
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=CATALOG --tags dbca
	ansible-playbook shard.yml -i rhel9d-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=EMEA --tags dbca
	ansible-playbook shard.yml -i rhel9e-26-restart.inventory.yml -e oracle_db_state=absent -e oracle_sid=APAC --tags dbca
