Role Name
=========

Installs Argo-web-api in host along with mongodb backend store

Requirements
------------

Inventory group `[webapi]` containing host with public ip, ansible `commons` and `mongodb` roles

Role Variables
--------------
Defaults:
- `argo_web_api_port`: 443 # port for argo web api to bind to
- `argo_core`: "argo_core" # name of core database
- `cors_support`: "true" # support for CORS

Additional:
- `web_api_admins` is used for defining a list of initial service admins
example below:
```yaml
webapi_admins:
   - name: "Admin name"
     email: "some@mail.foo"
     api_key: "s3cr3t-t0ken"
```

- `web_api_tenants` is used for defining a list of initial tenants for the service
example below:
```yaml
webapi_tenants:
 - id: "uuid-of-tenant"
   name: FOO
   email: foo@email.foo
   website: foowebsite
   db_conf:
     - store: ar
       server: localhost
       port: 27017
       database: arg_db_name1
       username: username
       password: "s3cret"
   users:
     - name: FOO_user
       email: something@something.foo
       token: "F00s3cretT0ken"
       roles:
         - admin
 - id: "a526e22d-09c7-420a-865c-b8df38056983"
   name: FOO2
   email: foo2@email.foo
   website: foowebsite2
   db_conf:
     - store: ar
       server: localhost
       port: 27017
       database: argo_db_name2
       username: username
       password: "s3cr3t"
   users:
     - name: FOO2_user
       email: something2@something.foo
       token: "F00-2-s3cretT0ken"
       roles:
         - admin
```

Dependencies
------------

This role depends on the following roles:
- `commons`
- `mongodb`

so the following external role variables must be set

- `repo_mongo`: true # in order to deploy mongodb service
- `repo_enabled_argo`: argo-devel # in order to deploy argo-web-api service

also the following firewall variable must be set for public access to the argo-web-api
```yaml
firewall_services_zones:
 - service: https
   zone: public
 - service: http
   zone: public
```

Example Playbook
----------------

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: webapi, task: deploy }
         - { role: webapi, task: init_api }

License
-------

Apache 2

Author Information
------------------

GRNET
