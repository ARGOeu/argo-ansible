Argo Messaging Push Server
=========

The push server role set ups and configures the ams push server, the component
responsible for executing the push functionality(consume->deliver->ack) for
the push enabled subscriptions of ams.

Requirements
------------

You will need a valid certificate in order for the push server to accept
tls connections.


Role Variables
--------------

Configuration variables needed for the service's config.

```

"service_port": 443,
"certificate": "/path/to/cert",
"certificate_key": "/path/to/key",
"certificate_authorities_dir": "/path/to/ca/dir",
"ams_token": push_worker_token,
"ams_host": "amshost.com",
"ams_port": 443,
"verify_ssl": "true",
"tls_enabled": "true"
"trust_unknown_cas": "false"
"log_level": "INFO",
"skip_subs_load": "false"

```

Dependencies
------------

Example Playbook
----------------

Including an example of how to use your role :

    - hosts: servers
    roles:
      - { role: push-server, task: push-server-setup, tags: push_install }

License
-------

Apache 2


Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
