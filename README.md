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

### Run extra tasks

Apart from deploying the standalone component there is also a list of task one may use to manage the component. 

#### Pause cron jobs

An example for poem_cron jobs pause

```bash
$ ansible-playbook -vvv standalone-pause.yml --extra-vars "cron_status=true" --tags poem_cron
``` 

where: 

 - **cron_status** : is the status of the cron job. It actually uses the disabled ansible paremeter. If true then cron job is disabled, if false the job is running
 - **tags** : The main tags are:
	 - poem_cron: Configure  poem connector per tenant cron job
	 - topology_cron: Configure topology connector per tenant cron job
	 - weights_cron: Configure weights connector per tenant cron job
	 - compute_job_hourly: Configure ar-compute job cycle hourly cron
	 - compute_job_daily: Configure ar-compute job cycle daily cron
	 - compute_poller_hourly: ar-compute poller hourly cron for tenant EGI
	 - cron_jobs: all jobs


#### Start stop services

Τhere are two main types of services. The egi specific services and the non-egi services which are based on the tenants name ( ex egicentral)

if you want to stop egi service you should run 

```bash
$ ansible-playbook standalone-start-stop.yml -vvv  --tags stop_egi_consumer'
``` 

If you want to start egicentral consumer

```bash
$ ansible-playbook standalone-start-stop.yml -vvv --extra-vars "consumer_name=egicentral" --tags start_consumer
``` 

where: 

 - **consumer_name** : is the the name of a tenant.
 - **tags** : The main tags are:
	 - stop_egi_consumer: stops egi consumer
	 - stop_all_consumer: stop all consumers
	 - stop_non_egi_consumer:  stop all non-egi consumers
	 - stop a consumer: stops a selected consumer_name consumer. When used you should provide a **consumer_name**.
	 - start_egi_consumer: start egi consumer
	 - start_all_consumer: start all consumers
	 - start_non_egi_consumer:  start all non-egi consumers
	 - start a consumer: start a selected consumer_name consumer. When used you should provide a **consumer_name**.

#### Delete a tenant

The `tenants_delete` variable contains a list of tenants who should no longer be
in the system, and these will be removed on the next ansible run. The format
is the following:

tenants_delete:
	- name: TEST
	- name: FOO
	
If you want to run this ansible script

```bash
$ ansible-playbook standalone-deletetenant.yml -vvv 
``` 


## Monitoring your services

In case you are using Nagios or Icinga for health monitoring purposes a minimal `is_monitored` role 
is included in the repo. The purpose of this role is to install and configure the nrpe service 
on your target machines. Modify the remote host variable within the `roles/is_monitored/defaults/main.yml` 
file and include it in your playbooks. 

These variables are:
 - monitoring_hosts: list of monitoring hosts
 - nrpe_allowed_hosts: a comma separated list of monitoring hosts (IPs).

## Users role

Role to manage users on a system. Based on [mivok/ansible-users](https://github.com/mivok/ansible-users/)

### Role configuration

* users_create_per_user_group (default: true) - when creating users, also
  create a group with the same username and make that the user's primary
  group.
* users_group (default: users) - if users_create_per_user_group is _not_ set,
  then this is the primary group for all created users.
* users_default_shell (default: /bin/bash) - the default shell if none is
  specified for the user.
* users_create_homedirs (default: true) - create home directories for new
  users. Set this to false is you manage home directories separately.

### Creating users

Add a users variable containing the list of users to add. A good place to put
this is in `group_vars/all` or `group_vars/groupname` if you only want the
users to be on certain machines.

The following attributes are required for each user:

* username - The user's username.
* name - The full name of the user (gecos field)
* uid - The numeric user id for the user. This is required for uid consistency
  across systems.
* password - If a hash is provided then that will be used, but otherwise the
  account will be locked
* groups - a list of supplementary groups for the user.
* ssh-key - This should be a list of ssh keys for the user. Each ssh key
  should be included directly and should have no newlines.

In addition, the following items are optional for each user:

* shell - The user's shell. This defaults to /bin/bash. The default is
  configurable using the users_default_shell variable if you want to give all
  users the same shell, but it is different than /bin/bash.

Example:

    ---
    users:
      - username: test
        name: Test Test
        groups: ['wheel','systemd-journal']
        uid: 1001
        ssh_key:
          - "ssh-rsa AAAAA.... foo@machine"
          - "ssh-rsa AAAAB.... foo2@machine"
    users_deleted:
      - username: bar
        name: Bar User
        uid: 1002

### Deleting users

The `users_deleted` variable contains a list of users who should no longer be
in the system, and these will be removed on the next ansible run. The format
is the same as for users to add, but the only required field is `username`.
However, it is recommended that you also keep the `uid` field for reference so
that numeric user ids are not accidentally reused.

