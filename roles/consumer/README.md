Connectors for ARGO 
============================

Installs all related connectors for ARGO. 

Requirements
------------
- OS: CentOS 7.x
- Grid Certificate already issued
- selinux disabled


Role Variables
--------------
General configuation variables

consumer_AMS_enabled: True
consumer_ams_configuration:
  PublishAms: True
  WriteAvro: True
  ams_host: ams_host domain 
  ams_type_of_data: sync_data
  ams_num_of_bulk: 100
  PackSingleMsg: True

consumer_tenants:
  TENANTA:
    topics:
      - "nagios.metricOutput.TENANTA.PROJECT.*"
    brokers:
      - "tenant.argo.grnet.gr"
    outputdir: "/mnt/data/argo-connectors/TENANTA/"
    AmsProject: TENANTA
    AmsToken: TESTTOKEN
    jobs_all: "JOBNAME"
    HTTPAuth: True # id httpauth is enabled
    AuthenticationUsePlainHttpAuth: True
    AuthenticationHttpUser: tenantA
    AuthenticationHttpPass: xxxxxx
    cron_weight_minute: 35
    MsgIngestion_BulkSize: 1
    MsgIngestion_Token: TEST_TOKEN
    jobs_details:
      - name: "JOBNAME"
        Directory: "Jobname"
        Profiles: "CRITICAL"
        TopoType: "TOPOLogy type (GOCDb)"
        TopoFeed: "https://toology_url/"
        TopoFeedPaging: False
        TopoFetchType: "Fetch Type"
        TopoSelectGroupOfEndpoints: "Monitored:Y"
        TopoSelectGroupOfGroups:


consumer_poem_servers: #list of poem servers needed
  - host: "tenanta.argo.grnet.gr"
    vos:
      - ops

consumer_tenants_delete: [] #list of tenants to delet
  - name: TenantA

consumer_poem_fetch_profiles: [] #list of profiles to check 

Configurations
----------------
### Templates

 - consumer.conf.j2	( Consumer configuration located at /etc/argo-{tenant}-consumer/consumer.conf  for each consumer) 
 - consumer.init.j2	(init scripts for non egi consumers. It creates an init script for each consumer /etc/init.d/argo-{tenant}-consumer )
 - customer.conf.j2	(Configure connectors located at /etc/argo-egi-connectors/{TENANT}-customer.conf for all tenants)
 - global.conf.j2	(Consumer global configuration template located at /etc/argo-egi-connectors/global.conf)
 - metric_data.avsc.j2	(metric avro specification for each tenant. It creates a /etc/argo-{TENANT}-consumer/metric_data.avsc file for each tenant) 
 - poem-connector.conf.j2	(Poem connector configuration file located at /etc/argo-egi-connectors/poem-connector.conf).
 
### Variables

The main variables you have to check

 - data_path: "/mnt/data/" for devel and "/var/lib/" for production the main data path 
 - consumer_path: /mnt/data/argo-egi-consumer and /var/lib/argo-connectors/ for production
 - enabled_argo_repo: argo-devel and argo-prod . 
 
### Consumer + Jobs + GocDB connectors variables 

All configuration is done in the `tenants` variable. The values of the variable are used to define:

 1. The tenants of the consumer
 2. The topics to collect data from per tenant and the broker endpoints to connect to
 3. Where to place the output files
 4. What jobs should be run per tenant
 5. In case a prefilter is needed the file name of the prefilter
 6. Per job the GocDB necessary information to collect topology files and downtimes

### Poem profiles variables

The poem connector is configured via two variables, namely `poem_servers` and `poem_fetch_profiles`. The first one defines per VO the poem service endpoint and the latter which POEM profiles should be collected on the host. 

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: consumer, task: deploy }
         - { role: consumer, task: connectors }
         - { role: consumer, task: cronjobs }

To deploy the devel instance use the following command

```bash
$ ansible-playbook -vvvv install.yml -i devel --limit [consumer-node].vm.okeanos.grnet.gr  
```

Related Tags: 

 - ar-packages (for argo related packages) 
 - consumer_config (for consumer cofiguration. reconfigure consumers (changes at corresponding host_vars and roles/consumer/defaults, roles/consumer/templates (consumer.conf.j2. consumer.init.j2 ) )
 - connectors ( argo-egi-connectors from ar project) 
 - connectors_config ( for connectors configuration) 
 - poem_config (for poem configuration) 
 - poem_cron (cron jobs)
 - topology_cron (cron jobs)
 - weights_cron (cron jobs)
 - cron_jobs (all cron jobs)
 
```bash
$ ansible-playbook -vvvv install.yml -i devel --limit [consumer-node].vm.okeanos.grnet.gr  --tags cron_jobs
```


License
-------

Apache 2

Author Information
------------------

GRNET
