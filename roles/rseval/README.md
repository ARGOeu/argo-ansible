Role Name
=========

Role to setup rseval web service


Requirements
------------
- OS: CentOS 7.x
- certificate already issued
- selinux disabled


Role Variables
--------------


Dependencies
------------

Dependent on mongo role using repo_mongo_4x: true

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

- hosts: rseval
  become: yes
  roles:
    - { role: mongodb }
    - { role: rseval, task: deploy, tags: rseval }

License
-------

Apache 2

Author Information
------------------

GRNET
