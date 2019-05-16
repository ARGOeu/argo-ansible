Cloudera Manager
============================

Prepares a node and deploys cloudera manager

Requirements
------------

Requires commons role and also depended with the following roles:
- cloudera_gateway
- cloudera_internal node


Role Variables
--------------
http_proxy_url: a valid url to the internal proxy (usually in the gateway vm)
postgres_pass: an already provided password (declared in hidden private repo files) to initialize database
postgres_internal_subnet: internal subnet that represents the private network of the clsuter so that postgres can listen to

Dependencies
------------

You need to specify the ansible inventory group that will consist your cluster
- cluster_group: c_cluster

You need for each host to set up the following variable for the private interface
private:
 - hostname: foo.host.priv  # private hostname alias  
   ip: 192.168.0.1 # private hostname
   id: 1  # private

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts: c_manager
  become: yes
  roles: 
    - { role: cloudera_manager }


License
-------

Apache 2

Author Information
------------------

GRNET
