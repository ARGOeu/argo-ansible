Apache
=========

Installs apache to remote host and sets up a secure configuration 
(Only for CentOS)

Requirements
------------

Inventory group `[apache]` contains hostnames. Each host must have a directory in `private_files` including the ssl certificates and a `host_var` file. The private files should include the ssl certificate with the following format where hostname=server name

- `key file`: hostname.key
- `cert file`: hostname.pem
- `ca chain file`: chain-hostname.key

Role Variables
--------------
Defaults:
- `cert_dir`: /etc/grid-security # directory to save certificates
- `cert_path`: /etc/grid-security/hostcert.pem
- `cert_key_path`: /etc/grid-security/hostkey.pem
- `ca_path`: /etc/pki/tls/certs/
- `ca_path/chain-{{inventory_hostname}}.pem`: /etc/pki/tls/certs/chain-host.pem
- `backup_dir`: '/var/apache_backup

If you want to add 2 virtualhosts in the same server with different names you should change the values of
`cert_path` and `cert_key_path` so the certificates will not be overwritten

The chain ca file is at `ca_path/chain-{{inventory_hostname}}.pem` and we dont just replace the ca-bundle.crt file under `/etc/pki/tls/certs/` because ca-bundle.crt is a symlink to to the aggregate ca certificates file.

Required host variables:

- `httpd`:
  - `rev_proxy`: # OPTIONAL if apache is reverse proxying a service
    - `ip`: service ip
    - `port`: service port
  - `static_dir`: directory path # OPTIONAL if apache serves static files
  - `extra_conf`: extra apache directives # OPTIONAL if virtualhost uses additional custom directives

example.com host_var
```yaml
httpd:
  static_dir: /var/www/html/example/
  extra_conf: |
    RequestHeader set X-Forwarded-Proto "https"
    RequestHeader set X-Forwarded-Port "443"

```

Example Playbook
----------------

    - hosts: apache
      roles:
         - { role: apache, tags: apache_install }

simple execution:
```bash
ansible-playbook -i devel argo-ansible/install.yml -t apache_install -u root -v
```

execution for clean install (remove `/etc/httpd/conf.d` and `/etc/httpd/conf` directory):
```bash
ansible-playbook -i devel -l apache argo-ansible/install.yml -t apache_install -u root -v --extra-vars "clean_install=True"
```

In case the following error occures use the `--ask-become-pass` to use a sudoers pass
```
TASK [commons : Check if chain file exists in private_files] **********************************************************************************************************
task path: /home/user/repos/argo/ansible/argo-ansible-deploy/argo-ansible/roles/commons/tasks/cert.yml:21
fatal: [jenkins.argo.grnet.gr]: FAILED! => changed=false
  module_stderr: |-
    sudo: a password is required
  module_stdout: ''
  msg: |-
    MODULE FAILURE
    See stdout/stderr for the exact error
  rc: 1
```

Execution with `--ask-become-pass`
```bash
ansible-playbook --ask-become-pass -i devel -l apache argo-ansible/install.yml -t apache_install -u root -vv
```

License
-------

Apache 2

Author Information
------------------

GRNET
