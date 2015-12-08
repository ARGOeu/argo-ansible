# ARGO via Ansible

## WebAPI deployment

Contains Ansible playbook for the deployment of the ARGO datastore and API service. The play is split into four (4) roles:
- repos (includes tasks for the installation of the required repository definitions)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- mongodb (installation and configuration of mongodb datastore)
- webapi (installation and bootstrap of ARGO api service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `hostkey.pem` and `hostcert.pem` respectively.
- Edit inventory and replace `webapi.node` with the hostname that you intend to deploy the API onto. 

### Prerequisites

- Deploy against CentOS 6.x node
- Make sure `libselinux-python` is installed on the target node
- Ansible version used is `1.7.2`

### How to deploy

```bash
$ ansible-playbook -v webapi.yml
```


## Web UI deployment

Contains Ansible playbook for the deployment of the ARGO Web UI service. The play is split into four (4) roles:
- firewall (configures iptables firewall rules)
- repos (includes tasks for the installation of the required repository definitions)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- webui (installation and bootstrap of ARGO Web UI service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `hostkey.pem` and `hostcert.pem` respectively.
- Edit inventory and replace `webui.node` with the hostname that you intend to deploy the Web UI onto. 
- Edit `roles/webui/vars/main.yml` file and change the values of the `certificate_password` and `keystore_password` variables to a stronger value.

### Prerequisites

- Deploy against CentOS 7.x node
- Ansible version used is `1.9.2`

### How to deploy

```bash
$ ansible-playbook -v webui.yml
```

## Full standalone deployment

Contains Ansible playbook for the deployment of all ARGO components. The play is split into six (6) roles:
- repos (includes tasks for the installation of the required repository definitions)
- ca_bundle (includes a task for the installation of the egi-ca-policy-core bundle)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- consumer (includes tasks for the installation of the ARGO consumer and feed components)
- mongodb (installation and configuration of mongodb datastore)
- webapi (installation and bootstrap of ARGO api service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `hostkey.pem` and `hostcert.pem` respectively.
- Edit inventory and replace `standalone.node` with the hostname that you intend to deploy the complete ARGO stack onto. 

### Prerequisites

- Deploy against CentOS 6.x node
- Make sure `libselinux-python` is installed on the target node
- Ansible version used is `1.7.2`

### How to deploy

```bash
$ ansible-playbook -v standalone.yml
```
