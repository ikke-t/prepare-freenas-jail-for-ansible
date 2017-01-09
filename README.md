# prepare-freenas-jail-for-ansible
This repo just holds helper script to prepare FreeNAS FreeBSD jail for ansible

Copy this file into your ```/<jail path>/tmp/prep-jail-for-ansible.sh```
and do run it in jail:
  ```jexec <jail name> /tmp/prep-jail-for-ansible.sh```
  
And have this as your ansible host vars:
```
[jails:vars]
  ansible_python_interpreter=/usr/local/bin/python
  ansible_user: ikke
  ansible_become: true
```

Credits for the script goes to (I recall) CQ in #freenas@freenode, which I modified a bit further to better suit my needs.
