Ansible role to deploy E-signature Rest API.
==============================================1

The role installs the ESEAl service.


Requirements
------------

Requires `commons` role ( `firewall` & `cert` ) and also depended with the `apache` role.


Role Variables
--------------

All variables described in `defaults/main.yml`


Dependencies
------------

- commons/firewall
- commons/cert
- apache


Example Playbook
----------------

How you can use the role:

```yaml
- hosts: eseal
  become: yes
  remote_user: root
  roles:
    - { role: commons,  task: firewall,  tags: firewall         }
    - { role: commons,  task: cert,      tags: cert             }
    - { role: commons,  task: rsyslog,   tags: rsyslog_conf     }
    - { role: apache,   task: main,      tags: apache_install   }
    - { role: eseal,    task: main,      tags: eseal            }
```

```bash
ansible-playbook -i devel argo-ansible/install.yml -vv --tags="eseal"
```


## Check the functionality with Ansible.
You can check if the endpoints work only with Ansible:

```bash
ansible-playbook -i devel argo-ansible/install.yml -vv --tags="eseal:check"
```


## Check the functionality manually.
You can check if the endpoints work with the following requests:

```bash
curl -X POST --insecure https://example.com/api/v1/validation/validateDocument
{
  "error" : {
    "code" : 400,
    "message" : "Malformed JSON body",
    "status" : "BAD_REQUEST"
  }
}
```

```bash
curl -X POST --insecure https://example.com/api/v1/signing/remoteSignDocument
{
  "error" : {
    "code" : 400,
    "message" : "Malformed JSON body",
    "status" : "BAD_REQUEST"
  }
}
```


* Documentation of E-SEAL Module: https://argoeu.github.io/gr.grnet.eseal/
* E-SEAL GitHub repository: https://github.com/ARGOeu/gr.grnet.eseal/tree/devel


License
-------

Apache 2


Author Information
------------------

GRNET



