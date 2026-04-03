## Create Database servers:

    ansible-playbook install_oracle_crs_26ai.yml -i ./rhel9de-26-rac.inventory.yml --skip oracledba
    ansible-playbook install_oracle_crs_26ai.yml -i ./rhel9fg-26-rac.inventory.yml --skip oracledba

## Create Databases:

    ansible-playbook emea_26ai.yml -i ./rhel9de-26-rac.inventory.yml
    ansible-playbook cat_26ai.yml -i  ./rhel9de-26-rac.inventory.yml
    
    ansible-playbook apac_26ai.yml -i ./rhel9fg-26-rac.inventory.yml


