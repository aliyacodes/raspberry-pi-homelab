#!/bin/bash
# sub-pi-03 (worker node)
sudo apt-get update && sudo apt-get upgrade -y

# COMMENTING OUT FOR SAKE OF ANSIBLE TESTING.  WILL TEST WITH THIS CODE LATER.
# chmod 700 .ssh
# chmod 600 .ssh/authorized_keys

# sudo adduser eros
# sudo usermod -aG sudo eros

# # Disable password based login
# sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# sudo systemctl reload ssh

# Change hostname
sudo hostnamectl set-hostname sub-pi-03

# Add host list to each machine
sudo sed -i '2 i 192.168.0.10 dom-pi \
192.168.0.11 sub-pi-01 \
192.168.0.12 sub-pi-02 \
192.168.0.13 sub-pi-03' /etc/hosts

# Enable cgroups
sudo sed -i 's/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1/' /boot/firmware/cmdline.txt

sudo systemctl reload ssh
sudo reboot # figure out how to do similar action without logging out
sudo apt-get update

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc

curl -sSL get.docker.com | sh

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo sh -c "echo '
      {
      \"exec-opts\": [\"native.cgroupdriver=systemd\"],
      \"log-driver\": \"json-file\",
      \"log-opts\": {
        \"max-size\": \"100m\"
      },
      \"storage-driver\": \"overlay2\"
      }' > /etc/docker/daemon.json"

sudo systemctl start docker
sudo systemctl enable docker

sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

sudo systemctl restart sshd

echo 'Checking Docker Status...'
systemctl status docker

echo 'Testing Docker "Hello-World"...'
docker run hello-world

# Kubernetes
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt update

sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

echo 'You may now join worker nodes to the cluster using \
"kubeadm join" command with token (do this from worker nodes)'