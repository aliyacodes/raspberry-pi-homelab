#!/bin/bash
# dom-pi (master node)
sudo apt update && sudo apt dist-upgrade -y

sudo chmod 700 .ssh
sudo chmod 600 .ssh/authorized_keys

sudo adduser eros
sudo usermod -aG sudo eros
sudo adduser eros root

# Disable password based login
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Change hostname
sudo sed -i 's/ubuntu/dom-pi/g' /etc/hostname

# Add host list to each machine
sudo sed -i '2 i 192.168.0.10 dom-pi \
192.168.0.11 sub-pi-01 \
192.168.0.12 sub-pi-02 \
192.168.0.13 sub-pi-03' /etc/hosts

# Enable cgroups
sudo sed -i 's/$/ cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt

# ??? sudo systemctl reload ssh

sudo apt update && sudo apt dist-upgrade -y

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo curl -sSL get.docker.com | sh

sudo groupadd docker
sudo usermod -aG docker $USER
sudo newgrp docker

sudo touch /etc/docker/daemon.json
sudo echo '{
      "exec-opts": ["native.cgroupdriver=systemd"],
      "log-driver": "json-file",
      "log-opts": {
        "max-size": "100m"
      },
      "storage-driver": "overlay2"
      }' > /etc/docker/daemon.json


sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# ??? sudo systemctl restart sshd

echo 'Checking Docker Status...'
systemctl status docker

echo 'Testing Docker "Hello-World"...'
docker run hello-world

# Kubernetes
sudo touch /etc/apt/sources.list.d/kubernetes.list 
sudo echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update

sudo apt install kubeadm kubectl kubelet -y

# Master/dom-pi only
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# View Pods
kubectl get pods --all-namespaces

echo 'You may now join worker nodes to the cluster using \
"kubeadm join" command with token'
