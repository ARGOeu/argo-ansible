Ansible role for MySQL backups.
=================================

The role installs the [argo-utils](https://github.com/ARGOeu/argo-utils/tree/devel/).


Requirements
------------

* MySQL/MariaDB.


Role Variables
--------------

> All variables described in `defaults/main.yml`

### Mandatory variables.
* `db_user`: The username of the database user who has the privileges to dump the database.
* `db_pass`: The password of the database user.
* `db_name`: The database we want to back up.
* `more_directories_to_backup` (optional): If you want, you can also archive together some extra directories. If you want to create a backup for more than one directories, you can set it as follows: `/var/www/site1:/var/www/site2`

### Option variables.
You can set these variables if you want to create a cron job to send archived backups to a remote machine.

* `remote_ip`: The IP of the remove machine.
* `remote_user`: The remote user.
* `remote_ssh_key`: An SSH public key in order to login with that in the remote machine.
* `remote_location`: The location of the remote machine to which you will send the archived backups.

If they are not defined in each host file, the following tasks are not running:
* `Copy SSH keys`
* `rSync backups cron jon`


Dependencies
------------

All that is needed is to have a MySQL/MariaDB database on the remote machine, and to know a user who has access to it.
Then if we want to send the backups to a remote machine, then we have to fill in the corresponding variables.


Example Playbook
----------------

How you can use the role:

```yaml
- hosts: mysql-databases
  become: yes
  remote_user: root
  roles:
    - { role: mysql,  task: backup,  tags: mysql-backup  }
```

## Deploy argo-utils, configure the cron jobs, ssh keys and create a backup archive.

```bash
ansible-playbook -i devel argo-ansible/install.yml -vv --tags "mysql"
```

## Just create backup archive.

```bash
ansible-playbook -i devel argo-ansible/install.yml -vv --tags "mysql:backup-now"
```

## Deploy everything, but don't create a backup archive now.
```bash
ansible-playbook -i devel argo-ansible/install.yml -vv --skip-tags "mysql:backup-now"
```


License
-------

Apache 2


Author Information
------------------

GRNET

