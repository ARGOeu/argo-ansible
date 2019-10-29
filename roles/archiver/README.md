Role Name
=========

The role installs the `ams-consumer` component and and it is used in order for data to be consumed from
AMS and then archived.

Requirements
------------

THe host needs to have access to the `argo.repo` and `epel.repo`

Role Variables
--------------

The role needs a list of projects and their respective info in order to start consuming and archiving data from AMS.

archiver_projects_list:
  - name: project_1
    token: token_1
    sub: sub1_
  - name: project_2
    token: token_2
    sub: sub_2
  
archiver_ams_host: msg.example.com

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
        - { role: archiver, task: archiver_setup, tags: archiver_setup }
License
-------

Apache License, Version 2.0

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
