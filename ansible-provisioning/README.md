# Docker Swarm + Consul Proof of Concept

To run this demo, simply adapt the hosts file and run the playbook.yml using ansible-playbook.

```
ansible-playbook -i hosts playbook.yml
```


It is advised to not include the Redmine role if you do not want to wait for a very long compile (Ansible copy is very slow in that role).
