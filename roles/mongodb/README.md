MongoDB Role
=========

MongoDB role sets up mongodb

Requirements
------------

Role Variables
--------------
* `mongo_bind_interfaces` : 127.0.0.1 # A Comma separated list of ips(interfaces) mongo should bind to

* `mongo_replicated` : false # If set to true mongodb will be deployed in a replicated fashion

* `mongo_repo` : # Set to `mongodb-org-3.2` to install `mongo-3.2` or `mongodb-org-4.0` to install `mongodb 4.0`

> * If you want to install **mongodb-org-3.2** you should set `repo_mongo:yes` in **commons** role

 > * If you want to install **mondodb-org-4.0** you should set `repo_mongo_4x:yes` in **commons** role

 * `mongo_backup_scripts_location` : variable for the location of the back up script

 * `mongo_replica_set_name` :  variable that controls the name of the replica set

 * `mongo_backup_dbs` : list variable that names the mongo databases that we want to backup.

Dependencies
------------

You need to specify the ansible inventory group that will consist your cluster
- e.g. mongo_cluster_group: mongo_private_cluster_devel

You need for each host to set up the following variable for the private interface
private:
 - hostname: foo.host.priv  # private hostname alias  
   ip: 192.168.0.1 # private hostname
   id: 1  # private



Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: mongodb }

License
-------

Apache License, Version 2.0
