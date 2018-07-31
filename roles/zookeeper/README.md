Zookeeper
=========

Installs a clustered zookeeper service 

Requirements
------------

Run commons role, Specify Cluster variables

Role Variables
--------------

zookeeper_maxClientCnxns: 60
zookeeper_myid: 1
zookeeper_tickTime: 2000
zookeeper_initLimit: 10
zookeeper_syncLimit: 5
zookeeper_dataDir: /var/lib/zookeeper
zookeeper_data_logDir: /var/lib/zookeeper
zookeeper_clientPort: 2181
zookeeper_leaderPort: 2888
zookeeper_electionPort: 3888

Dependencies
------------

Private cluster Variables:

You need to specify the ansible inventory group that will consist your cluster
- cluster_group: zookeeper

You need for each host to set up the following variable for the private interface
private:
 - hostname: foo.host.priv  # private hostname alias  
   ip: 192.168.0.1 # private hostname
   id: 1  # private


Example Playbook
----------------

    - hosts: zookeeper
      roles:
         - { role: zookeeper, tags: zookeeper_install }

License
-------

Apache 2

Author Information
------------------

GRNET
