Icinga Agent
=============

This role installs Icinga and configures it to act as an agent.
Icinga for either master/satellite/agent installs exactly the same infrastructure. After the installation of the basic packages, a different configuration is made depending on the purpose.

Requirements
------------

This role needs to be executed after `commons/firewall` role, so that the firewall on the machines is properly adjusted.

* For Debian or other GNU/Linux distributions, follow the instructions for the corresponding firewall at the end of the role.

Role Variables
--------------

* `icinga_master.domain` (**mandatory**) : The domain name of Icinga master.
* `icinga_master.port` (**mandatory**) : The port of Icinga master.
* `icinga_api_user.username` (**mandatory**) : The  username of `client-pki-ticket` **API user** from master (`/etc/icinga2/conf.d/api-users.conf`).
* `icinga_api_user.token` (**mandatory**) : The password of `client-pki-ticket` **API user** from master (`/etc/icinga2/conf.d/api-users.conf`).
* `group_vars/source` : The IPv4 address of the Icinga master, so as to allow communication with it from firewall.


Example Playbook
----------------
```
    - hosts: icinga_agent
      become: yes
      roles:
         - { role: icinga, tags: deploy_icinga_agent }
```


Example Inventory
-----------------
```
[icinga_agent]
node-agent    ansible_user=root
```

* Example 1:
```
ansible-playbook -i production argo-ansible/icinga-agent.yml --list-hosts --list-tasks

playbook: argo-ansible/icinga-agent.yml

  play #1 (all): all    TAGS: []
    pattern: ['all']
    hosts (1):
      snf-TEST.ok.net
    tasks:
      include   TAGS: [firewall]

  play #2 (icinga_agent): icinga_agent  TAGS: []
    pattern: ['icinga_agent']
    hosts (1):
      snf-TEST.ok.net
    tasks:
      icinga : Include common Icinga tasks for Master & Agent nodes.    TAGS: [deploy_icinga_agent]
      icinga : Installing some utils for Icigna TAGS: [deploy_icinga_agent]
      icinga : Set Agent script.    TAGS: [deploy_icinga_agent]
      icinga : Get ICINGA2_CA_TICKET from Icinga master TAGS: [deploy_icinga_agent]
      icinga : Execute Agent script TAGS: [deploy_icinga_agent]
      icinga : Restart Icinga 2 service.    TAGS: [deploy_icinga_agent]
      icinga : Don't forget to config your firewall!    TAGS: [deploy_icinga_agent]
```

<details>
<summary>Output.</summary>

```
changed: [snf-TEST.ok.net] => (item=icinga)

TASK [commons : Create firewall new services] *********************************************************************************************************************************************************************
changed: [snf-TEST.ok.net] => (item={'port': '5665/tcp', 'name': 'icinga_agent'})

TASK [commons : Add port to services] *****************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net] => (item={'port': '5665/tcp', 'name': 'icinga_agent'})

TASK [commons : Firewall add services to zones] *******************************************************************************************************************************************************************
changed: [snf-TEST.ok.net] => (item={'zone': 'icinga', 'service': 'icinga_agent'})

TASK [commons : Add sources to zones] *****************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net] => (item={'source': '83.212.76.0/21', 'zone': 'icinga'})

TASK [commons : Add interfaces to zones] **************************************************************************************************************************************************************************

RUNNING HANDLER [commons : restart firewall] **********************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

PLAY [icinga_agent] ***********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [snf-TEST.ok.net]

TASK [icinga : Include common Icinga tasks for Master & Agent nodes.] *********************************************************************************************************************************************
included: .../argo-ansible/roles/icinga/tasks/common_CentOS.yml for snf-TEST.ok.net

TASK [icinga : Add Icinga repository to package management configuration.] ****************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Some prerequisite tools.] **************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Install Icinga 2.] *********************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Ensure icinga2 service is started and enabled on boot.] ********************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Install Icinga 2 Check Plugins.] *******************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Install Icinga 2 SELinux policy and some utils.] ***************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Installing some utils for Icigna] ******************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Set Agent script.] *********************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Restart Icinga 2 service.] *************************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]

TASK [icinga : Don't forget to config your firewall!] *************************************************************************************************************************************************************
ok: [snf-TEST.ok.net] => 
  msg:
  - iptables/ip6tables
  - -A INPUT -p tcp -s 83.212.76.0/21 --dport 5665 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  - UFW
  - ufw allow from 83.212.76.0/21 to any port 5665
  - Firewalld.
  - firewall-cmd --new-zone=icinga --permanent
  - firewall-cmd --reload
  - firewall-cmd --zone=icinga --add-source=83.212.76.0/21
  - firewall-cmd --zone=icinga --add-port=5665/tcp
  - firewall-cmd --runtime-to-permanent
  - firewall-cmd --get-active-zones

RUNNING HANDLER [icinga : Restart Icinga 2 service.] **************************************************************************************************************************************************************
changed: [snf-TEST.ok.net]
```
</details>


* Example 2:
```
ansible-playbook -i production argo-ansible/icinga-agent.yml \
-e "icinga_master.domain=icinga.master.example.com icinga_master.port=5665 icinga_api_user.username=pki-user icinga_api_user.token=abcd123" \
--ssh-common-args='-o StrictHostKeyChecking=no' -vv --list-hosts --list-tasks

playbook: argo-ansible/icinga-agent.yml

  play #1 (icinga_agent): icinga_agent	TAGS: []
    pattern: ['icinga_agent']
    hosts (1):
     icinga-agent.example.com
    tasks:
      icinga_agent : Include common Icinga tasks for Master & Agent nodes.	TAGS: [deploy_icinga_agent]
      icinga_agent : Installing some utils for Icigna	TAGS: [deploy_icinga_agent]
      icinga_agent : Set Agent script.	TAGS: [deploy_icinga_agent]
      icinga_agent : Get ICINGA2_CA_TICKET from Icinga master	TAGS: [deploy_icinga_agent]
      icinga_agent : Execute Agent script	TAGS: [deploy_icinga_agent]
      icinga_agent : Restart Icinga 2 service.	TAGS: [deploy_icinga_agent]
      icinga_agent : Don't forget to config your firewall!	TAGS: [deploy_icinga_agent]
```



License
-------

Apache 2

Author Information
------------------
GRNET
