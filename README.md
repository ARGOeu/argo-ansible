## ARGO Ansible

Contains Ansible playbook for the deployment of the ARGO datastore and API services. The play is split into four roles:
- repos (includes tasks for the installation of the required repository definitions
- has_certificate (task for uploading the certificate file onto the host under the appropriate path)
- mongodb (installation and configuration of mongodb datastore)
- webapi (installation and bootstrap of ARGO api service)

