#!/bin/sh

multipass launch 18.04 --cpus 2 --disk 50G --mem 4G --name ubuntu --cloud-init - <<EOF
ssh_authorized_keys:
  - $(cat ~/.ssh/id_rsa.pub)
EOF
multipass set client.primary-name=ubuntu
multipass umount ubuntu
multipass mount ./share ubuntu:~/share
multipass info ubuntu
cd provisioning/
sed -i -e "/ansible_host=/d" inventory/inventory.ini
echo "ansible_host=$(multipass info ubuntu | grep IPv4 | awk '{print $2}')" >> inventory/inventory.ini
ansible-playbook site.yml -i ./inventory/inventory.ini
ssh -i ~/.ssh/id_rsa ubuntu@$(multipass info ubuntu | grep IPv4 | awk '{print $2}')
