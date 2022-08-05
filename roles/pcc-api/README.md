Ansible role to deploy PCC API.
=========

The role installs the PCC API.

Requirements
------------

- `MariaDB v.10.3`
- `JDK 11+`
- `Apache Maven 3.8.1+`

Role Variables
--------------

The main variables described in `defaults/main.yml`. 
You also need for each host to set up a file named `mariadb.yml` containing the following variable :

- `repo_mariadb: true`

The value of `repo_mariadb` should be true so that the ansible role can download the appropriate MariaDB version from the corresponding repository.

Dependencies
------------

- commons/timezone
- commons/repos
- commons/basic_utils
- commons/users
- commons/sshd
- commons/firewall
- commons/fail2ban
- commons/cert
- commons/rsyslog
- icinga_agent/deploy_icinga_agent

Example Playbook
----------------

How you can use the role:

```
- hosts: pcc-api
  become: yes
  roles:
    - { role: pcc-api,    task: main,    tags: pcc-api       }
```

* Deploy :
```bash
ansible-playbook -i pcc-api.ini argo-ansible/pcc-api-playbook.yml --vault-password-file=../vaultARGO
```

License
-------

Apache License, Version 2.0

Author Information
------------------

GRNET