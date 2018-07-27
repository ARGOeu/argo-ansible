Commons
=========

Commons role deploys some common stuff on all nodes

Consists of the following task:
- Firewall

Firewall task manages the firewall rules on the node. It uses a combination of ansible command and firewalld modules.
Sets desired interfaces to be unmanaged by NetworkManager and then resets FirewallD setting to the initial
Centos 7 deployment configuration (only public zone with ssh and dchp6-client). Then according to the declared firewall_ prefixed host_vars generates new zones, services, interfaces and services to zones mappings.

Requirements
------------

Selinux should be turned off

Role Variables
--------------

Firewall-related:

- firewall_unmanaged_nics: a list of interfaces to be unmanaged by NetworkManager
- firewall_sources: a list of sources to be created
- firewall_interfaces: a list of interfaces to be added to zones (items: {"interface":"ethX", "zone":"zone to map to"})
- firewall_zones: a list of zones to be created
- firewall_services: a list of services to be created (items: {"name": "service name", "port": "port_num/tcp"})
- firewall_services_zones: a list that maps services to zones (items: {"service":"service name", "zone": "zone to map to"})


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
         - { role: commons, x: 42 }

License
-------

Apache 2.0

Author Information
------------------

GRNET
