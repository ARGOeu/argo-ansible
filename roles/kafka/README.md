Kafka
=========

This role installs a kafka cluster for 1...N nodes (preferably keep N odd)

Requirements
------------

This role needs to be executed after commons and zookeeper roles (or a zookeeper
cluster should be already available)

Role Variables
--------------

None. See dependencies for other vars that must be set up

Dependencies
------------
Private cluster Variables:

You need to specify the ansible inventory group that will consist your cluster
- cluster_group: kafka

You need for each host to set up the following variable for the private interface
private:
 - hostname: foo.host.priv  # private hostname alias  
   ip: 192.168.0.1 # private hostname
   id: 1  # private 


commons-role-vars:
  repos_cloudera_kafka: true

  firewall_services:
    - name: kafka
      port: 9092/tcp

  firewall_services_zones:
    - service: kafka
      zone: internal


Example Playbook
----------------

    - hosts: kafka
      roles:
         - { role: kafka, tags: kafka_install }

License
-------

Apache 2

Author Information
------------------
GRNET
