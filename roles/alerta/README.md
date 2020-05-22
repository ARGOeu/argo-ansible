Role Name
=========

Role to setup an alerta node with the following services
- alerta-server
- alerta-web-ui
- alerta-amqp plugin
- alerta-mailer
- mongodb
- argo-alert-publisher service
- argo-rulegen service
- supervisord
- nginx (https enabled)
- uwsgi

Requirements
------------
- OS: CentOS 7.x
- certificate already issued
- selinux disabled


Role Variables
--------------


alerta_admin_list: a list of expected alerta admin usernames
alerta_plugin_list: a list of expected alerta enabled plugins
alerta_allowed_env_list: a list of expected alerta enabled environments
alerta_server_dir: path to install alerta server and python 3 virtual env
alerta_token: alerta service token to be used for cli/api access
alerta_dashboard_dir: '/var/www/html/'
alerta_dashboard_repo: https://github.com/alerta/alerta-webui.git
alerta_dashboard_release: version of dashboard
alerta_amqp_release: version (commit hash) of amqp plugin
alerta_mailer_release: version (commit hash) of mailer intergration
alerta_secret_key: alerta secret key hash
alerta: alerta version
alerta_server_version: alerta server version

alerta_main_mail: mail mail for notifications
alerta_mail_from: mail from 
alerta_smtp_host: smtp host used 
alerta_smtp_port: smtp port used
ssmtp_debug: if smpt will run in debug log mode

alerta_tenants:  - list of alerta tenants
  eudat: - tenant name 
    gocdb_auth_method: 'cert' - authentication method to gocdb
    gocdb_api_endpoint: gocdb endpoint to call
    gocdb_notification_flag: True/False if notification flag will be used
    gocdb_verify: True/False ssl verify gocdb connection
    gocdb_top_request: gocdb request pattern for top level group
    gocdb_sub_request: gocdb request pattern for second level group
    mail_template: path to mail text template to be used
    mail_template_html: path to html template to be used
    mail_type: html/text 
    mail_debug: true 
    alerta_environment: environment name to be used for each alert
    alert_extra_emails: a list of extra emails to be notified
    alert_timeout: how much until the alert to be considered stale
    alert_group: top level group name to be used in alerts
    ui_endpoint: url to the argo ui endpoint that serves a/r results

Dependencies
------------

Dependent on mongo role using repo_mongo_4x: true

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts: alerta
  become: yes
  roles:
    - { role: mongodb }
    - { role: alerta, task: deploy, tags: alerta }

License
-------

Apache 2

Author Information
------------------

GRNET
