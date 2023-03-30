Sample playbooks for ibre5041.ansible_oracle_modules_example galaxy collection:
Setup:

    ansible-galaxy collection install -r requirements.yml -v

Modify intentory file:

    emacs inventory/sample.restart.inventory.yml

Execute sample playbook:

    ansible-playbook oracle_oratab.yml -i inventory/sample.restart.inventory.yml
    
