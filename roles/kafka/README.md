Kafka
=========

This role installs a kafka cluster for 1...N nodes (preferably keep N odd)

Requirements
------------

This role needs to be executed after commons and zookeeper roles (or a zookeeper
cluster should be already available)

Role Variables
--------------

kafka_log_dirs: comma separated list with folder for kafka to store data

default_replication_factor: replication factor for automatically created topics

controlled_shutdown_enable: graceful shutdown, migrate partitions to others

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


Migration
---------

It is possible that when deploying a new Kafka cluster, you might already have some data that you would like to
bring over.After some experimentation migrating a 3-node kafka/zookeeper cluster, we came down to some important
steps that are needed in order, for the migration to be as successful as possible.


**Environment**
 - Centos7
 - Kafka was installed with yum using the `cloudera-kafka `repo
 - Zookeeper was installed with yum using the `cloudera-cdh5` repo
 - Kafka `log.dirs` was set to `/var/lib/kafka`
 - Zookeeper `dataDir` was set to `/var/lib/zookeeper`

1) Cut off all the dataflow coming into the cluster.

   If you are using kafka for an AMS cluster use:`systemctl stop argo-messaging`.

2) Start the migration process by shutting down the kafka nodes one by one.
   After finishing the kafka shutdown, move on to the zookeeper nodes.

3) In order to shut down the kafka nodes, first locate the leader and don't shut it down until it's the last one.

4) Make sure `controlled_shutdown_enable: true` is set in the server.properties file.

5) Visit each kafka node and use `systemctl stop kafka-server` or `/usr/lib/kafka/bin/kafka-server-stop.sh` to stop the service. Don't try to kill kafka's process directly because the graceful shutdown mechanisms won't activate. Each broker should take some time to shut down depending on the broker size so be patient.Logs will tell you when there are no more data to transfer.

6) Meanwhile you can observe the other nodes as they pick up data and state from the shut down node. You can check:

  - `/var/log/kafka/server.log`
  - `/var/log/kafka/controller.log`
  - `/var/log/kafka/state-change.log`.

7) Next, move to the zookeeper nodes and shut down the service using `systemctl stop zookeeper-server`. Follow the
same strategy as with kafka, meaning spot the leader and leave it for the end.
Again you can observe the logs at `/var/log/zookeeper/zookeeper.log`.

8) Now that the running cluster is shut down, make sure that the newly deployed kafka/zookeeper cluster is also shut down, as well as any dataflow or client that might be trying to communicate with them. Make sure that the listed directories are completely empty.

- `/var/lib/kafka`
- `/var/lib/zookeeper`

9) It's now time to move the data from the running cluster to the newly deployed one.
   From the running cluster copy all the contents from the directories:

- `/var/lib/kafka`
- `/var/lib/zookeeper`

  into the empty directories in the newly deployed cluster.

  **IMPORTANT NOTE: Make sure you align both zookeeper and kafka node data based on their id. That means that the data from kafka broker 0 should be moved to the new broker with id 0, same for zookeeper.**

10) After filling the aforementioned directories in the newly deployed cluster make sure you modify the ownership of the transferred files.

- `chown -R kafka:kafka /var/lib/kafka`
- `chown -R zookeeper:zookeeper /var/lib/zookeeper`

11) Finally reboot the newly deployed cluster.

**Validating Result**

When talking about migrating a kafka cluster being used by AMS, you can validate the result of the migration by using the following python [script](https://github.com/ARGOeu/argo-messaging/tree/devel/tools).
Use the script by running:

`./ams-export.py --mongo  ams01.priv:27017 --brokers ams01.priv:9092,ams02.priv:9092,ams03.priv:9092 --data ./dump export`

While the script's running you can observe what it's printing, if you see it `skipping...` means that something might have went wrong for the skipped topic. After the script's' finished running you can cross check the contents of the `dump` folder with the topics registered in zookeeper. You can find the topics on zookeeper by using:
`/usr/lib/zookeeper/zkCli.sh` and after you've entered the `zkClli` use `ls /brokers/topics`

**SIDENOTES**
 - In the newly deployed cluster, if you don't migrate the zookeeper data, kafka will load the topics data but won't be able to display them.
 - If you notice that some topics don't respond when trying to pull messages, probably something went wrong during   the moving of data from cluster to cluster or a kafka node wasn't properly shut down, so useful data for a topic's partitions were lost.

 - Whenever facing problems try the kafka scripts found in `/usr/lib/kafka/bin`
    `kafka-topics.sh` will give you information about certain topics
    `kafka-consumer-consumer.sh` with the option `--from-beginning` will help you pull messages from a topic and investigate its contents.

 - Logs with `This server is not the leader for that topic-partition.` again indicate some problematic behaviour of the imported data.

License
-------

Apache 2

Author Information
------------------
GRNET
