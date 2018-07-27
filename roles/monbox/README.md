MonBox
=========

This role deploys ARGO monitoring engine. 

Requirements
------------
 - Centos7
 - Selinux should be turned off
 - Vm should be rebooted
 - A grid certificate
 - A user account with project for AMS Service

Role Variables
--------------

## Group Vars
In group_vars/monbox 
There is a list of variables used in monbox:
# needed to enable the nagios repo
repo_nagios: true

## CGI vars ##
the DN's allowed to run service commands
monbox_authorized_for_all_service_commands:
  - "/C=LL/O=edu/OU=srce/CN=LL"
  - "/C=GR/O=HellasGrid/OU=grnet.gr/CN=LL"

the DN's allowed to run host commands
monbox_authorized_for_all_host_commands:
  - "/C=LL/O=edu/OU=srce/CN=LL"
  - "/C=GR/O=HellasGrid/OU=grnet.gr/CN=LL"

# firewall settings for all monbox hosts
firewall_services_zones:
 - service: https
   zone: public
 - service: http
   zone: public

firewall_interfaces:
 - interface: eth1
   zone: public

## Host Vars
monbox_nagios_components: the nagios components to install 
monbox_nagios_plugins: the necessary plugins 
monbox_nagios_epel_plugins: the epel plugins


#ncg.conf variables
MONBOX_NAGIOS_ADMIN: An email to send alerts
MONBOX_VO: the name of VO (ex. ops)
monbox_gocdb_root_url:  the GOCDB Url (https://goc-test.argo.grnet.gr/gocdbpi/)
MONBOX_NAGIOS_ROLE: the type of role (ex PROJECT) 
monbox_poem_url:  the poem urli (ex. https://poem-test.argo.grnet.gr/poem) 
MONBOX_TENANT: tenants name (ex TEST, EGI) 
MONBOX_PROBES_TYPE: the probes type (ex. local) 

A number of variables are also defined in defaults file of role. 

## Private Files

In private files folder the following files are required:
 - {{inventory_name}}.key
 - {{inventory_name}}.pem
 - {{inventory_name}}.pem
 - files/ncg.localdb : with the local configurations 
 - files/plugins/: with plugins configurations
 - files/etc/nagios/htpasswd.users : the users allowed to access the monbox



Dependencies
------------

A list of other roles (internal, or from galaxy)  are used to deploy the monbox:
 
 - { role: commons, task: timezone, tags: timezone}
 - { role: commons, task: repos, tags: repos }
 - { role: commons, task: basic_utils, tags: basic_utils }
 - { role: commons, task: firewall, tags: firewall }
 - { role: commons, task: cert, tags: cert }
 - { role: commons, task: fail2ban, tags: fail2ban }
 - { role: nickhammond.logrotate, tags: logrotate}
 - { role: monbox, tags: deploy }
 - { role: httpd, tags: httpd }
 - { role: monbox, tags: config }

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts: monbox
  become: yes
  roles:
    - { role: commons, task: timezone, tags: timezone}
    - { role: commons, task: repos, tags: repos }
    - { role: commons, task: basic_utils, tags: basic_utils }
    - { role: commons, task: firewall, tags: firewall }
    - { role: commons, task: cert, tags: cert }
    - { role: commons, task: fail2ban, tags: fail2ban }
    - { role: monbox, tags: deploy }
    - { role: nickhammond.logrotate, tags: logrotate}
    - { role: httpd, tags: httpd }
    - { role: monbox, tags: config }

License
-------

Apache-2

Author Information
------------------

GRNET
