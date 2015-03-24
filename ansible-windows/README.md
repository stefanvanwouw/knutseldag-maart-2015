Ansible, controlling Windows hosts
----------------------------------

Steps followed to test the Windows functionality
--------------------

1. Get facts from windows hosts
2. Create and remove local windows user (standard Ansible role)
3. Install and remove program with msi (standard Ansible role)
4. Execute Powershell script
5. Use Powershell helper parts from Ansible

Preparation
------------

Server: winRm python package
`pip install http://github.com/diyan/pywinrm/archive/master.zip#egg=pywinrm`

Server: inventory

```
[win-dev]
windows-dev..nl

[win-test]
windows-test.geodan.nl
```

Server: group_vars
```
# it is suggested that these be encrypted with ansible-vault:
# ansible-vault edit group_vars/windows.yml

ansible_ssh_user: ansible
ansible_ssh_pass: SomeSecretPassword
ansible_ssh_port: 5986
ansible_connection: winrm
```

Prepare controlled windows machine:
See:  https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1

Script opens Winrm and firewall for all hosts. For security reasons it might be better to restrict access to the specific control machine

If still using Powershell 2 first upgrade: https://github.com/cchurch/ansible/blob/devel/examples/scripts/upgrade_to_ps3.ps1

To see which WinRM listeners are configured use in Powershell:  `winrm e winrm/config/listener`

Test setup and connection
-------------------------

From machine running Ansible:  `ansible -i win-inventory win-test -m setup` or `ansible -i win-inventory win-ontw -m win_ping`

Windows-stat module :

```
- name: test stat module
  hosts: win-ontw
  tasks:
    - name: test stat module on file
      win_stat: path="C:/Windows/win.ini"
      register: stat_file

    - debug: var=stat_file

    - name: check stat_file result
      assert:
          that:
             - "stat_file.stat.exists"
             - "not stat_file.stat.isdir"
             - "stat_file.stat.size > 0"
             - "stat_file.stat.md5"
```

Create windows user 
-------------------

```yml
- name: Create local windows user
  hosts: win-dev
  tasks:
    - name: test win user 
      win_stat: path="C:/Windows/win.ini"
      register: stat_file
```

Windows get url 
---------------

```yml
---
# Playbook example
- name: Download notepad++ install file
  hosts: win-dev
  gather_facts: false

  tasks:
    - win_get_url:
        url: 'http://dl.notepad-plus-plus.org/downloads/6.x/6.7.5/npp.6.7.5.Installer.exe'
        dest: 'C:/Temp/npp.6.7.5.Installer.exe'
```



Resources:
----------

- http://docs.ansible.com/intro_windows.html
- http://oriolrius.cat/blog/2015/01/29/ansible-and-windows-playbooks/
