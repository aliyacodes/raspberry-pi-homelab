#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo fdisk -l 

blkid /dev/sda1 # take note of UUID and TYPE
# my output --> /dev/sda1: LABEL_FATBOOT="UNTITLED" LABEL="UNTITLED" UUID="F4A8-11F8" TYPE="vfat"

lsblk

# install two packages to add support for the exFAT filesystem
sudo apt install exfat-fuse -y 

sudo apt install exfat-utils

# make a directory where we will mount our drive to
sudo mkdir -p /mnt/usb1

# give user "ubuntu" ownership of this directory
sudo chown -R ubuntu:ubuntu /mnt/usb1

# modify fstab file
# (This file controls how drives are mounted to your Raspberry Pi)
sudo vim /etc/fstab

# Enter this line: UUID=[UUID] /mnt/usb1 [TYPE] defaults,auto,users,rw,nofail,noatime 0 0
# replacing [UUID] and [TYPE] with output of "blkid /dev/sda1"
UUID=F4A8-11F8 /mnt/usb1 vfat defaults,auto,users,rw,nofail,noatime 0 0

# unmount the drive for good measure (may or may not be mounted)
sudo umount /dev/sda1

# mount the drive
sudo mount -a

# reboot to make sure the drives are restored
sudo reboot

# check to see if the disk has mounted properly
lsblk

# change permissions
find /mnt/usb1/ -type d -exec chmod 755 {} \;
find /mnt/usb1/ -type f -exec chmod 644 {} \;

###########################################
# SAMBA SETUP

sudo apt-get update && sudo apt-get upgrade -y

# install the packages that we require to setup Samba
sudo apt-get install samba samba-common-bin -y

# create a shared directory
mkdir /home/ubuntu/shared

# modify smb.conf config file
sudo vim /etc/samba/smb.conf

# enter text:
[myexternaldrive]
path = /home/ubuntu/shared
writeable=Yes
create mask=0777
directory mask=0777
public=no

# setup a user and password for Samba share
sudo smbpasswd -a ubuntu
# ENTER PASSWORD ^

#restart samba service so it loads config changes
sudo systemctl restart smbd

# print out pi's local IP address, if we don't already know it
hostname -I



##### sources #####

# https://pimylifeup.com/raspberry-pi-mount-usb-drive/

# https://pimylifeup.com/raspberry-pi-samba/

