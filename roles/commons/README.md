Commons
=========

Commons role deploys some common stuff on all nodes

Consists of the following tasks:

- firewall
Firewall task manages the firewall rules on the node. It uses a combination of ansible command and firewalld modules.
Sets desired interfaces to be unmanaged by NetworkManager and then resets FirewallD setting to the initial
Centos 7 deployment configuration (only public zone with ssh and dchp6-client). Then according to the declared firewall_ prefixed host_vars generates new zones, services, interfaces and services to zones mappings.

- sshd
Reconfigures sshd to not allow password authentication

- cert
Deploys host certificate on node

- fail2ban
Deploys fail2ban service

- timezone
Sets preferred timezone on host

- is_monitored
Configures host to be monitored by nagios

- repos
Deploys additional repos on host

- users
Create users and their homedirs ([Guidelines for users](README_users.md)

- rsyslog
Configures rsyslog to forward logs to a remote rsyslog server aswell

Requirements
------------

Selinux should be turned off

Role Variables
--------------

firewall related:
- firewall_private_interfaces: a list of interfaces to be in private networks
- firewall_sources: a list of sources to be created
- firewall_interfaces: a list of interfaces to be added to zones (items: {"interface":"ethX", "zone":"zone to map to"})
- firewall_zones: a list of zones to be created
- firewall_services: a list of services to be created (items: {"name": "service name", "port": "port_num/tcp"})
- firewall_services_zones: a list that maps services to zones (items: {"service":"service name", "zone": "zone to map to"})

sshd related:
- sshd_config_path: path to configuration file of ssh daemon (default: /etc/ssh/sshd_config)

cert related:
- cert_dir: path to certificate directory
- cert_path: path to certificate directory
- cert_key: path to host key
- ca_path: path to ca cert folder
- ca_path_bundle: path to ca bundle file

is_monitored related:
- nrpe_conf_path: path for configuration of nrpe module
- nrpe_allowed_hosts: list of allowed host to monitor using nrpe

repo related
(boolean flags to enable on demand deployment of following repos):
- repo_cloudera_kafka: false
- repo_enabled_argo: argo-devel  # from which repo to get the packages (argo-devel or argo-prod)
- repo_mongo: false  # if you want to install mongo repository (3.2 version)
- repo_mongo_4x: false # if you want to install mongo repository (4.0 version)
- ca_bundle: false  # if you want to install EGI-trustanchors repository
- repo_qcg: false
- repo_unicore: false
- repo_umd: false
- repo_promoo: false
- repo_rocci: false
- repo_cloudera: false
- repo_cloudera_kafka: false
- repo_nagios: false


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in
regards to parameters that may need to be set for other roles, or variables that
are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: commons, task: sshd }
         - { role: commons, task: firewall }
         #...etc

License
-------

Apache 2.0

Author Information
------------------

GRNET
