Apache
=========

Installs apache to remote host and sets up a secure configuration 
(Only for CentOS)

Requirements
------------

Inventory group `[apache]` containing hostnames. Each host must have a directory in `private_files` including the ssl certificates and a `host_var` file.

Role Variables
--------------
Defaults:
- `cert_dir`: /etc/certs # directory to save certificates
- `backup_dir`: '/var/apache_backup

Required host variables:

- `httpd`:
  - `vhost_name`: name # filename for the virtualhost file
  - `chain`: chain ca certifiace filename 
  - `cert`: certifiace filename
  - `key`: certifiace key filename
  - `server`: server name
  - `rev_proxy`: # OPTIONAL if apache is reverse proxying a service
    - `ip`: service ip
    - `port`: service port
  - `static_dir`: directory path # OPTIONAL if apache serves static files
  - `file_extend`: file path # OPTIONAL if virtualhost uses additional custom directives

example.com host_var
```yaml
cert_dir: /etc/certs
httpd:
  vhost_name: example
  chain: chain-ca.crt
  cert: example.argo.grnet.gr.pem
  key: example.argo.grnet.gr.key
  server: example.argo.grnet.gr
  static_dir: /var/www/html/example/
  file_extend: private_files/example.argo.grnet.gr/virtualhost_directives.conf

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

License
-------

Apache 2

Author Information
------------------

GRNET
