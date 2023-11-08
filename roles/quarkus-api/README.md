quarkus-api Role
=========

quarkus-api role sets up a quarkus api.

Requirements
------------

Role Variables
--------------

* `quarkus_api.jar_name` : The jar name may express the name of your project e.g. `cat-api.jar`. Otherwise, choose your preferable name.

* `quarkus_api.service_name` : The service name may express the name of your project e.g. `cat-api.service`. Otherwise, choose your preferable name.

* `quarkus_api.repo_url` : The API git repository URL.

* `quarkus_api.doc_url` : The API documentation URL.

* `quarkus_api.description` : The API description.

* `quarkus_api.log` : The API name used in jinja rsyslog template.

* `environment_variables` : The environment variables that API needs to run.

* `files` : You can use the following parameters to download a file from a specific URL and place it in a directory. 
     - `directory` : The directory where the file will be placed.
        - `url` : The URL where the file is located.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
- hosts: server
  become: yes
  roles:
    - { role: quarkus-api,    task: quarkus-api,    tags: quarkus-api       }
```
* Deploy :
```bash
ansible-playbook -i cat-api-devel.ini argo-ansible/cat-api-playbook.yml --vault-password-file=../vaultARGO
```

* Update only:
```bash
ansible-playbook -i cat-api-devel.ini argo-ansible/cat-api-playbook.yml --vault-password-file=../vaultARGO --tags="quarkus-api-update"
```

License
-------

Apache License, Version 2.0
