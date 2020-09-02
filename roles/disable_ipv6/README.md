Disable Ipv6 stack
============================

Disables nodes ipv6 stack options in sysctl without reloading and apply them

Requirements
------------

Ability to access the nodes through public or private IPv4 networks

Role Variables
--------------


Dependencies
------------

User should reboot or reload sysctl after the role is run (because maybe the ansible uses the ipv6 network already)

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts:  servers
  become: yes 
  roles: 
    - { role: disable_ipv6 }



License
-------

Apache 2

Author Information
------------------

GRNET