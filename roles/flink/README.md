Role Name
=========

Deploy a flink cluster with standalone scheduler

Requirements
------------
- cloudera_gateway
- cloudera_manager

Role Variables
--------------

flink_version: 1.3.2 - the version of flink to be deployd
flink_scala_version: "2.10" - the version of scala 
flink_hadoop_version: "26" - the corresponding version of hadoop 
flink_dir: /opt/flink_{{flink_version}} - the directory where flink will be deployed
flink_url: https://archive.apache.org/dist/flink/flink-{{flink_version}}/flink-{{flink_version}}-bin-hadoop{{flink_hadoop_version}}-scala_{{flink_scala_version}}.tgz - url template for downloading flink tars

flink_master: master.example - hostname of the flink master
flink_master_ip: 192.168.0.1 - ip of the flink master
flink_task_slots: 4 - configure how many tasks slots will be in each master

java_home: /usr/lib/jvm/jre-1.8.0-openjdk - path to the installed java


flink_slaves: - list of nodes to be flink task managers
  -
    hostname: slave01.example - hostname of the flik task manager node
    ip: 192.168.0.2 - private ip of the flink task manager node
  -
    hostname: slave02.example
    ip: 192.168.0.3

flink_is_master: false - boolean if the node will be a master (jobmanager)

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

- hosts: c_flink
  become: yes
  roles: 
    - { role: flink }

License
-------

Apache 2.0

Author Information
------------------

GRNET
