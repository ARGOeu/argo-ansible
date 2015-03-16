## ARGO Ansible

Contains Ansible playbook for the deployment of the ARGO datastore and API services. The play is split into four roles:
- repos (includes tasks for the installation of the required repository definitions
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- mongodb (installation and configuration of mongodb datastore)
- webapi (installation and bootstrap of ARGO api service)

### Things to do before deployment

- Obtain a key/certificate pair from a trusted CA and after place them both under roles/has_certificate/files.
- Edit inventory and replace =webapi.node= with the hostname that you intend to deploy the API onto. 

### Prerequisites

- Deploy against CentOS 6.x node
- Ansible version used is `1.7.2`

### How to deploy

```bash
$ ansible-playbook -v webapi.yml
```