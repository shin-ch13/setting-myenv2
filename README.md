# setting-myenv2

Apple M1でVirtualBox + Vagrantが利用できなくなったため更改
https://github.com/shin-ch13/setting-myenv

## Host Environment

* OS
  * macOS 12.3.1 (Apple M1)
* Software
  * [multipass 1.9.2](https://multipass.run/docs)

## Install & Setup

Install mutipass

```shell
% brew install --cask multipass
```

Create mounte Volume

```shell
% mkdir ~/multipass/ubuntu
```

Create and Start a new instance on multipass

```shell
% multipass launch --cpus 2 --disk 50G --mem 4G --name ubuntu
% multipass set client.primary-name=ubuntu
% multipass info ubuntu
% multipass umount ubuntu
% multipass mount ~/multipass/ubuntu ubuntu:~/ubuntu
% multipass info ubuntu
```

Use an instance on multipass

```shell
% multipass shell
```

Manage an instance on multipass

```shell
% multipass list # List an instance
% multipass start # Start an instance
% multipass stop # Stop an instance
% multipass delete # Delete an instance
% multipass purge # Permanently Remove an instance
```

## Run Example

## Links

