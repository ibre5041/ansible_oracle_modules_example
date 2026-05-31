
all:
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i gsm-shard-emea.inventory.yml --skip oracledb
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i gsm-shard-apac.inventory.yml --skip oracledb
	#
	ansible-playbook listeners.yml -i gsm-shard-emea.inventory.yml
	ansible-playbook listeners.yml -i gsm-shard-apac.inventory.yml
	#
	ansible-playbook cat_26ai.yml  -i gsm-shard-emea.inventory.yml
	#
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531

db:
	ansible-playbook cat_26ai.yml -i gsm-shard-emea.inventory.yml
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531

shard:
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530 #--tags=wallet
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531 #--tags=wallet

	ansible-playbook shard.yml -i gsm-shard-apac.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530 --tags=oracle_listener,files,wallet
	ansible-playbook shard.yml -i gsm-shard-apac.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531 --tags=oracle_listener,files,wallet

clean_db:
	ansible-playbook cat_26ai.yml  -i gsm-shard-emea.inventory.yml -e oracle_db_state=absent -e oracle_sid=CATALOG --tags dbca
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml     -e oracle_db_state=absent -e oracle_sid=EMEA --tags dbca
	ansible-playbook shard.yml -i gsm-shard-emea.inventory.yml     -e oracle_db_state=absent -e oracle_sid=APAC --tags dbca
