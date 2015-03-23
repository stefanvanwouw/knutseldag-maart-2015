Ansible, controlling Windows hosts
----------------------------------

Wat
---

1. systeem info opvragen
2. windows user (standaard rol)
3. install msi (standaardb rol)
4. remove msi (standaard rol)
5. uitvoeren eige powershell

Voorbereiden
------------

Server: winRm python package
`pip install http://github.com/diyan/pywinrm/archive/master.zip#egg=pywinrm`



Server: inventory

```
[win-ontw]
wingis.geodan.nl

[win-test]
wingis.test.geodan.nl
```

Server: group_vars
```
# it is suggested that these be encrypted with ansible-vault:
# ansible-vault edit group_vars/windows.yml

ansible_ssh_user: ansible
ansible_ssh_pass: SuperGeheimeWachtwoord
ansible_ssh_port: 5986
ansible_connection: winrm
``

Client, volgens https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1
                https://github.com/cchurch/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1
Dit script zet alles in winrm open; beter is het om de listener alleen te laten luisteren naar 1 ip nummer (bv van de Ansible machine)

Eerst Powershell 3 : https://github.com/cchurch/ansible/blob/devel/examples/scripts/upgrade_to_ps3.ps1

Om te zien welke WinRm listeners er zijn in Powershell uitvoeren:
`winrm e winrm/config/listener`

Test: `ansible -i win-inventory win-test -m setup`
of ` ansible -i win-inventory win-ontw -m win_ping`



Ansible versie: `ansible --version`, geeft lokaal:  _ansible 1.9 (devel 86202b9fe3) last updated 2014/11/27 13:33:10 (GMT +200)_


Testje met windows-stat module :
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


Windows user aanmaken
---------------------
```yml
- name: test windows user aanmaken
  hosts: win-ontw
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
- name: Download notepad install file
  hosts: win-ontw
  gather_facts: false

  tasks:
    - win_get_url:
        url: 'http://dl.notepad-plus-plus.org/downloads/6.x/6.7.5/npp.6.7.5.Installer.exe'
        dest: 'C:/Temp/npp.6.7.5.Installer.exe'
```



Resources:
----------

http://docs.ansible.com/intro_windows.html
http://oriolrius.cat/blog/2015/01/29/ansible-and-windows-playbooks/