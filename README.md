# ARGO via Ansible

This repository contains a collection of Ansible roles and playbooks that aim at easing the deployment procedure of ARGO products. The goal for these roles and playbooks has been to be as generic as possible so that they are easily adaptable to different environments and e-Infrastructure requirements. Hence most of the variables used by default in these roles reside under the `roles/{role_name}/defaults/main.yml` files. 

The administrator of the ARGO product being deployed via these Ansible playbooks may use any of the following places in order to successfully overwrite the default values of the variables and adapt the ARGO product to the specific environment and requirements:
- `roles/{role_name}/vars/main.yml`
- `groups_vars/{groups_name}`
- `host_vars/{inventory_hostname}`

Per ARGO product more details on prerequisites and variables are given in the following subsections.

## Messaging API

Contains Ansible playbook for the deployment of the ARGO Messaging API. The play is split into the following roles:
- selinux (disables selinux)
- firewall (configures iptables firewall rules)
- repos (includes tasks for the installation of the required repository definitions)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- zookeeper (installs and bootstraps zookeeper)
- kafka (installs and bootstraps kafka)
- mongodb (installs and bootstraps mongodb)
- messaging_api (installs and bootstraps messaging_api)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `{{inventory_hostname}}.key` and `{{inventory_hostname}}.pem` respectively. As `{{inventory_hostname}}` use the exact name used within the `inventory` file. 
- Edit inventory and replace `messaging.node` with the hostname that you intend to deploy the Messaging service onto. 
- Create a `host_vars/{{inventory_hostname}}` file and place therein the variables found within the 
	- `roles/messaging_api/defaults/main.yml` file in order to overwrite them. 
 	- `roles/zookeeper/defaults/main.yml` file in order to overwrite them.
 	- `roles/mongodb/defaults/main.yml` file in order to overwrite them.
 	- `roles/kafka/defaults/main.yml` file in order to overwrite them.
 	
### Prerequisites

- Deploy against CentOS 7.x node
- Ansible version used is `1.9.2`

### How to deploy

```bash
$ ansible-playbook -v messaging_api.yml
```

### Default Values
The script creates some defaults:
 
 - Project: ARGO
 - Users:
   - admin:ADMINTOKEN
   - viewer:VIEWERTOKEN 
 - BASIC URL: [MESSAGING_DOMAIN]/v1/
 
 for more information about the messaging API please visit the [SWAGGER API Description](https://api-doc.argo.grnet.gr/argo-messaging/)

## WebAPI deployment

Contains Ansible playbook for the deployment of the ARGO datastore and API service. The play is split into four (4) roles:
- repos (includes tasks for the installation of the required repository definitions)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- mongodb (installation and configuration of mongodb datastore)
- webapi (installation and bootstrap of ARGO api service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `{{inventory_hostname}}.key` and `{{inventory_hostname}}.pem` respectively. As `{{inventory_hostname}}` use the exact name used within the `inventory` file. 
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

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `{{inventory_hostname}}.key` and `{{inventory_hostname}}.pem` respectively. As `{{inventory_hostname}}` use the exact name used within the `inventory` file. 
- Edit inventory and replace `webui.node` with the hostname that you intend to deploy the Web UI onto. 
- Edit `roles/webui/vars/main.yml` file and change the values of the `certificate_password` and `keystore_password` variables to a stronger value.

- Note that by default the EGI based web UI will be deployed on your target node. To change this behaviour use the `argo_web` and `branch_name` variables within the `roles/webui/vars/main.yml` file to point to another upstream lavoisier repository. 

### Prerequisites

- Deploy against CentOS 7.x node
- Ansible version used is `1.9.2`

### How to deploy

```bash
$ ansible-playbook -v webui.yml
```

## POEM deployment

Contains Ansible playbook for the deployment of the ARGO POEM service. The play is split into four (4) roles:
- firewall (configures iptables firewall rules)
- repos (includes tasks for the installation of the required repository definitions)
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- poem (installs and bootstraps poem service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `{{inventory_hostname}}.key` and `{{inventory_hostname}}.pem` respectively. As `{{inventory_hostname}}` use the exact name used within the `inventory` file. 
- Edit inventory and replace `poem.node` with the hostname that you intend to deploy the POEM service onto. 
- Create a `host_vars/{{inventory_hostname}}` file and place therein the variables found within the `roles/poem/defaults/main.yml` file in order to overwrite them. 
  - In order to generate a uuid to be used in the place of the `poem_secret` variable you may use the `uuidgen` linux cli utility. 

### Prerequisites

- Deploy against CentOS 6.x node
- Make sure `libselinux-python` is installed on the target node
- Ansible version used is `1.9.2`

### How to deploy

```bash
$ ansible-playbook -v poem.yml
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

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files with names `{{inventory_hostname}}.key` and `{{inventory_hostname}}.pem` respectively. As `{{inventory_hostname}}` use the exact name used within the `inventory` file. 
- Edit inventory and replace `standalone.node` with the hostname that you intend to deploy the complete ARGO stack onto. 

### Prerequisites

- Deploy against CentOS 6.x node
- Make sure `libselinux-python` is installed on the target node
- Ansible version used is `1.7.2`

### How to deploy

```bash
$ ansible-playbook -v standalone.yml
```


## Monitoring your services

In case you are using Nagios or Icinga for health monitoring purposes a minimal `is_monitored` role is included in the repo. The puspose of this role is to install and configure the nrpe service on your target machines. Modify the remote host variable within the `roles/is_monitored/defaults/main.yml` file and include it in your playbooks. 
