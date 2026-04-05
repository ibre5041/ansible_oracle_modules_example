
all:
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9d-26-restart.inventory.yml --skip oracledb
	ansible-playbook install_oracle_restart_26ai.vmware.yml -i rhel9e-26-restart.inventory.yml --skip oracledb
	ansible-playbook install_gsm.yml -i gsm-emea.yml
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml
	ansible-playbook emea_26ai.yml -i rhel9d-26-restart.inventory.yml
	ansible-playbook apac_26ai.yml -i rhel9e-26-restart.inventory.yml

db:
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml
	ansible-playbook emea_26ai.yml -i rhel9d-26-restart.inventory.yml
	ansible-playbook apac_26ai.yml -i rhel9e-26-restart.inventory.yml

clean_db:
	ansible-playbook cat_26ai.yml  -i rhel9d-26-restart.inventory.yml --extra-vars "oracle_db_state=absent" --tags dbca
	ansible-playbook emea_26ai.yml -i rhel9d-26-restart.inventory.yml --extra-vars "oracle_db_state=absent" --tags dbca
	ansible-playbook apac_26ai.yml -i rhel9e-26-restart.inventory.yml --extra-vars "oracle_db_state=absent" --tags dbca
