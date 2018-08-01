Argo Authentication Service
=========

The argo-api-authn role set ups and configures the argo authentication service as well as some utility scripts for interacting with other services.

Requirements
------------

The argo authentication service uses mongo as its store.

You will also need to issue a valid certificate for the web server to work properly.


Role Variables
--------------

Configuration variables needed for the service's config.

```

authn_service_port: 8443
authn_mongo_host: localhost
authn_mongo_db: argo_auth
authn_certificate_authorities: /etc/grid-security/certificates
authn_certificate: /etc/grid-security/hostcert.pem
authn_certificate_key: /etc/grid-security/hostkey.pem
authn_service_token: some-token
authn_verify_ssl: "true"
authn_trust_unknown_cas: "false"
authn_verify_certificate: "true"

```

Configuration variables for the ams-gocdb-users-create script

```

ams:
  project: some project
  goc_db_host: https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type={% raw -%}{{service-type}}{% endraw -%} # {% raw -%} and {% endraw -%} are used to escape {{ }}
  service_types: gLite-APEL, eu.egi.cloud.accounting, eu.egi.storage.accounting
  users_role: publisher
  token: some-token
  host: hotst1
  email: goc_db_user

authn:
  token: some-token
  host: host1/authn
  service_uuid: df3c5a33-dfe3-4b20-9395-5e1d04b96211
  service_host: some-host

logs:
  syslog_socket: /dev/log

```


Dependencies
------------

Example Playbook
----------------

Including an example of how to use your role :

    - hosts: servers
    roles:
      - { role: mongodb }
      - { role: argo-api-authn, task: authn-setup }
      - { role: argo-api-authn, task: ams-gocdb-users-create-script }

License
-------

Apache 2


Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
