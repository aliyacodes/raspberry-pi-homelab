#!/bin/bash
# sub-pi-02 (worker node)
sudo apt update && sudo apt upgrade -y

chmod 700 .ssh
chmod 600 .ssh/authorized_keys

sudo adduser eros
sudo usermod -aG sudo eros

# Disable password based login
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

sudo systemctl reload ssh

# Change hostname
sudo hostnamectl set-hostname sub-pi-02

# Add host list to each machine
sudo sed -i '2 i 192.168.0.10 dom-pi \
192.168.0.11 sub-pi-01 \
192.168.0.12 sub-pi-02 \
192.168.0.13 sub-pi-03' /etc/hosts

# Enable cgroups
sudo sed 's/$/ cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt

# ??? sudo systemctl reload ssh

sudo apt update && sudo apt dist-upgrade -y

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc

curl -sSL get.docker.com | sh

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo echo '{
      "exec-opts": ["native.cgroupdriver=systemd"],
      "log-driver": "json-file",
      "log-opts": {
        "max-size": "100m"
      },
      "storage-driver": "overlay2"
      }' > /etc/docker/daemon.json


sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

sudo systemctl restart sshd

echo 'Checking Docker Status...'
systemctl status docker

echo 'Testing Docker "Hello-World"...'
docker run hello-world

# Kubernetes
sudo echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update

sudo apt install kubeadm kubectl kubelet -y
