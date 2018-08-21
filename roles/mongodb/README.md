MongoDB Role
=========

MongoDB role sets up mongodb

Requirements
------------

You will need to have the repo `mongodb-org-3.2` on the host.

Role Variables
--------------
mongo_bind_interfaces: 127.0.0.1 # A Comma separated list of ips(interfaces) mongo should bind to
mongo_replicated: false # If set to true mongodb will be deployed in a replicated fashion

Dependencies
------------

You need to specify the ansible inventory group that will consist your cluster
- cluster_group: mongo_cluster

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
