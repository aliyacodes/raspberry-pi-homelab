#!/bin/bash
# pi_life.sh

ssh ubuntu@192.168.0.xx # change password
cat ~/.ssh/id_rsa.pub | ssh ubuntu@192.168.0.10 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

chmod 700 .ssh
chmod 600 .ssh/authorized_keys

sudo adduser eros
sudo usermod -aG sudo eros

# Disable password based login
sudo vim /etc/ssh/sshd_config
PasswordAuthentication no --> line 58
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config


# Change hostname
sudo vim /etc/hostname # --> replace line 1
sed -i 's/ubuntu/dom-pi/g' /etc/hostname
sed -i 's/ubuntu/sub-pi-01/g' /etc/hostname
sed -i 's/ubuntu/sub-pi-02/g' /etc/hostname
sed -i 's/ubuntu/sub-pi-03/g' /etc/hostname


# Add host list to each machine
sudo vim /etc/hosts # --> insert at line 2
sed -i '2 i 192.168.0.10 dom-pi \
192.168.0.11 sub-pi-01 \
192.168.0.12 sub-pi-02 \
192.168.0.13 sub-pi-03' /etc/hosts


# enable cgroups
#sudo vim /boot/firmware/cmdline.txt
#add to line --> cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory #swapaccount=1
sed 's/$/ cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt

sudo systemctl reload ssh
sudo reboot
sudo apt update && sudo apt dist-upgrade



# DOCKER
# Install Docker Engine on Ubuntu Using Repository

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Set up the repository
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# arm64
echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Verify that Docker Engine is installed correctly
sudo docker run hello-world

# Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker


sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Verify that Docker Engine is installed correctly
docker run hello-world

sudo vim /etc/docker/daemon.json #?
sudo vim /etc/systctl.conf #? net ipv4 forward

# https://docs.docker.com/get-started/resources/
# https://www.pluralsight.com/courses/kubernetes-getting-started
# https://www.linuxserver.io/
# https://www.youtube.com/watch?v=qv3_gLvjITk
# https://wiki.learnlinux.tv/index.php/Setting_up_a_Raspberry_Pi_Kubernetes_Cluster_with_Ubuntu_20.04

# pull and run prep.sh
# curl -sL \
# https://gist.githubusercontent.com/alexellis/fdbc90de7691a1b9edb545c17da2d975/raw/b04f1e9250c61a8ff554bfe3475b6dd050062484/prep.sh \
# | sudo sh

# https://www.youtube.com/watch?v=qv3_gLvjITk

# KUBERNETES

# all nodes
sudo apt install kubeadm kubectl kubelet

# master/dom only

token

mkdir -p $HOME/.kube
etc
etc
apply yaml file

kubectl get pods --all-namespaces


Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.10:6443 --token gnjsud.f29q61fkxkbbox7y \
--discovery-token-ca-cert-hash sha256:12535c56eff0ca797010c331ec9db136e651f4b58ee688e9494cb85507bccc6f 



http://192.168.0.10:30080/


##### NAS #####

# https://www.pcmag.com/how-to/how-to-turn-a-raspberry-pi-into-a-nas-for-whole-home-file-sharing

# https://www.pcmag.com/how-to/how-to-turn-a-raspberry-pi-into-a-nas-for-whole-home-file-sharing


# https://pimylifeup.com/raspberry-pi-mount-usb-drive/

# https://pimylifeup.com/raspberry-pi-samba/

eros@dom-pi:~$ hostname -I
192.168.0.10 172.17.0.1 10.244.0.0 10.244.0.1 

sudo chmod +x /mnt/usb1
eros@dom-pi:~$ sudo systemctl restart smbd

df -h
  232  sudo blkid /dev/sda1
  233  sudo apt install exfat-fuse
  234  sudo apt install exfat-utils
  235  sudo mkdir -p /mnt/usb1
  236  sudo chown eros -R eros:eros /mnt/usb1
  237  groups
  238  groups linuxize
  239  groups eros
  240  sudo chown -R eros:eros /mnt/usb1
  241  sudo vim /etc/fstab
  242  fdisk
  243  history
  244  sudo fdisk -l
  245  sudo umount /dev/sda1
  246  sudo mount -a
  247  sudo fdisk -l
  248  history
  249  lsblk
  250  sudo reboot
  251  lsblk
  252  sudo apt-get update
  253  sudo apt-get upgrade
  254  sudo apt-get install samba samba-common-bin
  255  history
  256  ls
  257  sudo vim /etc/samba/smb.conf 
  258  cd /mnt/usb1/
  259  pwd
  260  cd
  261  sudo vim /etc/samba/smb.conf 
  262  sudo smbpasswd -a eros

 lsblk
  252  sudo apt-get update
  253  sudo apt-get upgrade
  254  sudo apt-get install samba samba-common-bin lsblk
  252  sudo apt-get update
  253  sudo apt-get upgrade
  254  sudo apt-get install samba samba-common-bin
    257  sudo vim /etc/samba/smb.conf 
    sudo smbpasswd -a eros
  266  sudo systemctl restart smbd
  267  hostname -I
sudo chmod +x /mnt/usb1
sudo systemctl restart smbd

https://fleet.linuxserver.io/image?name=linuxserver/code-server

https://hub.docker.com/r/linuxserver/code-server

# sed -i '2 i 192.168.0.10 dom-pi' /xxx/xxxx.txt ???


eros@dom-pi:~$ sudo blkid /dev/sda1
/dev/sda1: LABEL="MyExternalDrive" UUID="1a736786-aaaf-4b00-91a1-bb4e8918c428" TYPE="ext4" PARTLABEL="MyExternalDrive" PARTUUID="13adfdef-036b-4b6f-909a-10d24f605375"
eros@dom-pi:~$

Automating Docker and Kubernetes basic install and setup for Raspberry Pi 4 cluster/homelab.  Work in progress.


# kubernetes stuff

kubectl get deployment --namespace=kube-system

kubectl get deployment -l k8s-app=kube-dns --namespace=kube-system

https://opensource.com/article/17/3/building-personal-web-server-raspberry-pi-3


# Cloudflare
https://pimylifeup.com/raspberry-pi-port-forwarding/




sudo sh -c "echo '
      {
      \"exec-opts\": [\"native.cgroupdriver=systemd\"],
      \"log-driver\": \"json-file\",
      \"log-opts\": {
        \"max-size\": \"100m\"
      },
      \"storage-driver\": \"overlay2\"
      }' > test.json"

