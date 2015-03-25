#!/bin/sh

apt-get install -y python-pip wget sshpass
pip install ansible

echo "[defaults]\nhost_key_checking=False\n" > /root/ansible.cfg
