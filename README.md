# setting-myenv2

Apple M1でVirtualBox + Vagrantが利用できなくなったため更改. 
<https://github.com/shin-ch13/setting-myenv>

## Host Environment

* OS
  * macOS 12.3.1 (Apple M1)
* Software
  * [multipass 1.9.2](https://multipass.run/docs)
  * [Ansible 2.9.x](https://docs.ansible.com/)

## Install & Setup

Install mutipass and ansible

```shell
% brew install --cask multipass
% brew install ansible@2.9
% echo 'export PATH="/opt/homebrew/opt/ansible@2.9/bin:$PATH"' >> ~/.zshrc
```

Create and Start a new instance on multipass

```shell
% git clone https://github.com/shin-ch13/setting-myenv2
% cd setting-myenv2/
% multipass launch 18.04 --cpus 2 --disk 50G --mem 4G --name ubuntu --cloud-init - <<EOF
ssh_authorized_keys:
  - $(cat ~/.ssh/id_rsa.pub)
EOF
% multipass set client.primary-name=ubuntu
% multipass umount ubuntu
% multipass mount ./share ubuntu:~/share
% multipass info ubuntu
```

Setting myenv to instance

```shell
% cd provisioning/
% sed -i -e "/ansible_host=/d" inventory/inventory.ini
% echo "ansible_host=$(multipass info ubuntu | grep IPv4 | awk '{print $2}')" >> inventory/inventory.ini
% ansible-playbook site.yml -i ./inventory/inventory.ini
```

Use an instance on multipass

```shell
% ssh -i ~/.ssh/id_rsa ubuntu@$(multipass info ubuntu | grep IPv4 | awk '{print $2}')
```

Manage an instance on multipass

```shell
% multipass list # List an instance
% multipass start # Start an instance
% multipass stop # Stop an instance
% multipass delete # Delete an instance
% multipass purge # Permanently Remove an instance
```
