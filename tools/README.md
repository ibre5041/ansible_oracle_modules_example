# Create/Delete/Clone VMs on VMware/VCenter

Although there is support for VCenter in Ansible, this module can not create RAC cluster.
There is missing support to add multiple SCSI adapters, and to add shared disks.

clone.py and delete.py scripts can read either config file in proprietary format or ansible inventory file.
These scripts can also create/delete DNS records for VMs

$ ./clone.py -h
usage: clone.py [-h] [-f FILE | -i INVENTORY]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Config filename to process in .yaml format
  -i INVENTORY, --inventory INVENTORY
                        Config filename to process in ansible inventory format

Create 2 node RAC cluster on VMware:

./clone.py -i ../inventory/rac19-b.050.inventory.yml
