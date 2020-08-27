sSMTP Role
=========

sSMTP role sets up sSMTP MTA so that you can send emails from your virtual machine (VM) via `relay.grnet.gr`.
> Of course the role can also be used to set up email through other providers with minor changes.

Requirements
------------

You should be allowed to send emails through the grnet relay. To be allowed, you should contact the support department at `support@grnet.gr`.

Role Variables
--------------

The role has no variables and essentially does not need any variables to execute.
However, for the better user experience only, the following **optional** variables have been defined:

* `domain` (optional) : The domain name of the machine through which the test email will be sent.
* `ansible_user_email` (optional) : The email address to which the test email will be sent.

> As understood from the above, the role at the end for testing purposes also undertakes to send a test email to an address of your choice.

The above variables can be defined very easily in the `host_vars` file of the target machine.


Example Playbook
----------------

```
- name: sSMTP
  hosts: all
  roles:
    - {role: 'ssmtp', tags: 'MTA'}
```

License
-------

Apache 2.0

Author Information
------------------

GRNET
