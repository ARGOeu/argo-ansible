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

 * `is_arbiter`: boolean variable that declares if a host that belongs to a replica set will have the role of an arbiter.

  * `mongo_port`: declares the port on which the replica member listens, defaults to **27017**.

  * `mongo_log_rotate`: enables logrotate script for MongoDB log at <i>/var/log/mongodb.log</i>

  ---
  :warning: <b><i>NOTE</i></b> :warning:

  When declaring the hostnames in the inventory group make sure to NOT have the
  arbiter(s) machine(s) first.

e.g.
```
[mongo_private_cluster_devel]
 mongo1.grnet.gr
 mongo2.grnet.gr
 mongo-arbiter.grnet.gr
```

In case you don't want to rely on the order of the hosts, you should declare
the variable `is_arbiter` on each one of the host's host vars file.

---


Dependencies
------------

<b>You need to specify the ansible inventory group that will consist your cluster
- e.g. mongo_cluster_group: mongo_private_cluster_devel</b>

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
