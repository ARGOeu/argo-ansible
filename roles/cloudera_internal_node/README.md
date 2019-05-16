Cloudera Internal Node
============================

Prepares a node for taking part in a cloudera cluster (HDFS)

Requirements
------------

Requires commons role and also depended with the following roles:
- cloudera_gateway
- cloudera_manager


Role Variables
--------------
General configuation variables

ntp_server: local ntp server to listen to to the private network
cloudera_gateway_pub_key: pub key to be authorized to be accessible from gateway node
cloudera_manager_pub_key: pub key to be authorized to be accessible from cloudera manager node
through_http_proxy: so that node's services can be setup to use the lan http proxy

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

- hosts: c_private
  become: yes 
  roles: 
    - { role: through_http_proxy }
    - { role: cloudera_internal_node }


License
-------

Apache 2

Author Information
------------------

GRNET
