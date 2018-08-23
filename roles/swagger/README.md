Role Name
=========

Install swagger documentation

Requirements
------------

Selinux disabled on target node.

Role Variables
--------------
`swagger_docs` is a list of dictionaries containing references to swagger definitions (github_repo, branch, api_host, etc)

```yaml
swagger_docs:
  - { github_org: swagger-api, name: swagger-spec , branch: master, path_to_yaml: "examples/v2.0/yaml/petstore.yaml" , api_host: "petstore.swagger.io"}
```


Dependencies
------------

Uses Httpd and Commons roles.
Following variables should be set-up for swagger http access (from role: commons, task: firewall)
```yaml
firewall_services_zones:
 - service: https
   zone: public
 - service: http
   zone: public
```

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: httpd }
         - { role: swagger}

License
-------

Apache 2.0

Author Information
------------------

GRNET
