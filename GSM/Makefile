
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

duplicate:
	ansible-playbook duplicate.yml -i gsm-shard-apac.inventory.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=EMEA -e shard_listener_port=1530
	ansible-playbook duplicate.yml -i gsm-shard-apac.inventory.yml -i gsm-shard-emea.inventory.yml -e oracle_sid=APAC -e shard_listener_port=1531

clean_db:
	ansible-playbook drop_database.yml -i gsm-shard-emea.inventory.yml -e db_unique_name=CATALOG_RW
	ansible-playbook drop_database.yml -i gsm-shard-apac.inventory.yml -e db_unique_name=EMEA_AT_APAC
	ansible-playbook drop_database.yml -i gsm-shard-apac.inventory.yml -e db_unique_name=APAC_AT_APAC
	ansible-playbook drop_database.yml -i gsm-shard-emea.inventory.yml -e db_unique_name=EMEA_AT_EMEA
	ansible-playbook drop_database.yml -i gsm-shard-emea.inventory.yml -e db_unique_name=APAC_AT_EMEA
