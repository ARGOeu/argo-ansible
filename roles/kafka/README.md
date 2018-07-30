Kafka
=========

This role installs a kafka cluster for 1...N nodes (preferably keep N odd)

Requirements
------------

This role needs to be executed after commons and zookeeper roles (or a zookeeper 
cluster should be already available)

Role Variables
--------------

kafka_broker_id: an integer signified the broker and should be unique for each node
kafka_zookeeper_connect: a list of zookeeper nodes (host:port) for the broker to connect to

Dependencies
------------

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
