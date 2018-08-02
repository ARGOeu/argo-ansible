Metrics Role
=========

Metrics role includes task to set up the ams metrics ui and the compute engine comparisons script.


Role Variables
--------------

Variables for ams-metrics-ui task


metrics_ui_superadmin_key: valid ams token for superadmin
metrics_ui_projectadmin_key: valid ams token for a projectadmin
metrics_ui_publisher_key: valid ams token for a publisher
metrics_ui_consumer_key: valid ams token for a consumer
metrics_ui_apiurl: https://messaging-devel.argo.grnet.gr/v1/
metrics_ui_usersurl: https://messaging-devel.argo.grnet.gr/v1/users
metrics_ui_projectsurl: https://messaging-devel.argo.grnet.gr/v1/projects
metrics_ui_metricsurl: https://messaging-devel.argo.grnet.gr/v1/metrics



Variables for compute engine comparison script


logs:
  log_level: info
  handler_path: /dev/log

tenants:
  - TENANTA:
    name: TENANTA
    hadoop: host1/api/v2/results/Critical/SERVICEGROUPS?start_time={start_date}T00%3A00%3A00Z&end_time={start_date}T23%3A53%3A00Z
    flink: host2/api/v2/results/Critical/SERVICEGROUPS?start_time={start_date}T00%3A00%3A00Z&end_time={start_date}T23%3A53%3A00Z
    hadoop_token: some_token
    flink_token: some_token
  - TENANTB:
    name: TENANTB
    hadoop: host1/api/v2/results/Critical/SITES?start_time={start_date}T00%3A00%3A00Z&end_time={start_date}T23%3A53%3A00Z
    flink: host2/api/v2/results/Critical/SITES?start_time={start_date}T00%3A00%3A00Z&end_time={start_date}T23%3A53%3A00Z
    hadoop_token: some_token
    flink_token: some_token

start_date: "2018-01-12"

end_date: "2018-01-24"

save_location: ./generated_reports/

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: metrics, x: ams-metrics-ui }
         - { role: metrics, x: ce_comp }

License
-------

Apache 2

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
