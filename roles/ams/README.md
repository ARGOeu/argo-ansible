AMS (Argo Messaging Service)
============================

Installs a clustered AMS service.

Requirements
------------

Requires commons role, private cluster vars to be set and also the following
roles to be run in prior:
 - zookeeper
 - kafka

Role Variables
--------------
General configuation variables

ams_bind_ip: ''
ams_port: 443
ams_store_host: 'localhost'
ams_store_db: 'argo_msg'
ams_zookeeper_hosts: "localhost:2181"
ams_kafka_znode: ''
ams_per_resource_auth: 'true'
ams_log_level: 'INFO'
ams_metrics_token: 'secret_key' this should be overridden in host vars
ams_service_token: 'secret_key' this should be overridden in host vars

Variables for initializing database with projects and users
 ams_data_projects:
   -  name: TEST #the project name
      uuid: project_UUID #the project UUID

 ams_data_users:
   -  username: default_service_admin
      uuid: user_UUID1 #the user's UUID
      key:  user_key #the user's key
      service_roles:
        - service_admin
      email: service_admin@argo.example.foo
   -  username: default_project_admin
      uuid: user_UUID2 #the users UUID
      projects:
        - project_uuid: project_UUID #the project UUID
          roles:
           - project_admin
      key: project_admin_key
      email: project_admin@argo.example.foo
      created_by: user_UUID1

Dependencies
------------

You need to specify the ansible inventory group that will consist your cluster
- cluster_group: kafka

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
         - { role: ams, task: deploy }
         - { role: ams, task: init_db }
         - { role: ams, task: metrics }


License
-------

Apache 2

Author Information
------------------

GRNET
