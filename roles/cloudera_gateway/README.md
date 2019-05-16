Cloudera Gateway
============================

Prepares a gateway node for taking part in a cloudera cluster (HDFS)

Requirements
------------

Requires commons role and also depended with the following roles:
- squid (for having an http proxy for the internal nodes)
- cloudera_internal_node
- cloudera_manager


Role Variables
--------------


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

- hosts: c_gateway
  become: yes
  roles: 
    - { role: squid }
    - { role: cloudera_gateway}


License
-------

Apache 2

Author Information
------------------

GRNET