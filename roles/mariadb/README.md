Ansible role to deploy a mysql database.
=========

The role installs the mysql database.

Role Variables
--------------

The main variables described in `defaults/main.yml`. 
You also need for each host to set up a file named `mariadb.yml` containing the following variable :

- `repo_mariadb: true`

The value of `repo_mariadb` should be true so that the ansible role can download the appropriate MariaDB version from the corresponding repository.

Example Playbook
----------------

How you can use the role:

```
- hosts: api
  become: yes
  roles:
    - { role: mariadb,    task: main,    tags: mariadb       }
```

License
-------

Apache License, Version 2.0

Author Information
------------------

GRNET