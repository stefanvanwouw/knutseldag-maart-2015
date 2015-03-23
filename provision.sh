#!/bin/sh

apt-get install -y python-pip wget sshpass
pip install ansible




#cp /vagrant/private_key /home/vagrant/.ssh/private_key
#chmod 0400 /home/vagrant/.ssh/private_key
#chown vagrant:vagrant /home/vagrant/.ssh/private_key

echo "[defaults]\nhost_key_checking=False\n" > /root/ansible.cfg
#cd /vagrant/ansible-provisioning
#ansible-galaxy install alexeymedvedchikov.rabbitmq
#ansible-playbook -i /vagrant/ansible-provisioning/hosts /vagrant/ansible-provisioning/message_broker.yml
