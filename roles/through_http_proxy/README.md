Through Http Proxy
============================

Prepares a node's services: yum, wget, curl to use a designated http proxy

Requirements
------------

A valid http proxy present in the local network

Role Variables
--------------
http_proxy: url to a valid http proxy (http://example.proxy.local:3128)

Dependencies
------------


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts:  servers
  become: yes 
  roles: 
    - { role: through_http_proxy }



License
-------

Apache 2

Author Information
------------------

GRNET
