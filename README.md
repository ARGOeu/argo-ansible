# ARGO via Ansible

This repository contains a collection of Ansible roles and playbooks that aim at easing the deployment procedure of ARGO products. The goal for these roles and playbooks has been to be as generic as possible so that they are easily adaptable to different environments and e-Infrastructure requirements. Hence most of the variables used by default in these roles reside under the `roles/{role_name}/defaults/main.yml` files. 

The administrator of the ARGO product being deployed via these Ansible playbooks may use any of the following places in order to successfully overwrite the default values of the variables and adapt the ARGO product to the specific environment and requirements:
- `roles/{role_name}/vars/main.yml`
- `groups_vars/{groups_name}`
- `host_vars/{inventory_hostname}`

Per ARGO product more details on prerequisites and variables are given in the following subsections.

## Run or Develop Ansible Playbooks

- In order to run an ansible playbook, you need to make sure that you are using `ansible 2.6`.

- In order to develop new playbooks you will also need to have `docker` and `molecule`.

To make the set up process easier, you will have to create a virtual environment executing the following steps:
 
 - Make sure you have `python2.7` installed
 
 - Update `pip`
 
 `pip install --upgrade pip`
 
 - Install the virtualenv package
 `pip install virtualenv`
 
 -  Create the new virtual environment 
 
 `virtualenv --python=/usr/bin/python2.7 ./argo-ansible-env`
 
 - Navigate inside the virtual environment and activate it
 
 `cd argo-ansible-env && source ./bin/activate`
 
 - Clone the repo and install the appropriate packages
  
  After cloning the repo,navigate inside it, and issue the command
  
  `pip install -r requirements.txt`
 
