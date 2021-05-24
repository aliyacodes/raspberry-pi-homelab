# raspberry-pi-homelab

### **NOTE:** This repo contains pieces of code that make up my Raspberry Pi Homelab, but they are not yet ready to be treated as one cohesive project.  Files currently work independently of one another.   

<br>
#### As I begin to document this project in a public format, I want to remind myself and others that this should be completely accessible.  It will take me many tries to make that possible, but I will keep changing and adding to its content until it is completely understandable and reproducable by anyone who has never touched this kind of hardware or software before.  
<br>


 

<br>  

# Hardware  

* 4x Raspberry Pis (You do not need entire kit or 8GB. 4GB is ideal. Cluster cases usually come with fans and heat sinks.)  
[CanaKit Raspberry Pi 4 8GB Starter Kit - 8GB RAM](https://www.amazon.com/gp/product/B08956GVXN/ref=ppx_yo_dt_b_asin_image_o01_s00?ie=UTF8&psc=1)  

* 4X SD Cards (SD cards come with the Cannakit along with SD card adapter/reader, but can be purchased separately.)  
[SAMSUNG 32GB Evo Plus Class 10 Micro SDHC with Adapter - Pack of 5](https://www.amazon.com/Samsung-Class-Micro-Adapter-MB-MC32GA/dp/B07NP96DX5/ref=sr_1_4?dchild=1&keywords=32gb+samsung+micro+sd&qid=1621358686&s=electronics&sr=1-4)  

* 1x Unmanaged Switch (PoE Switch is ideal but more expensive. If using PoE switch, can omit power hub and USB cables)  
**May need additionnal PoE Hat for Raspberry Pi*  
[NETGEAR 5-Port Gigabit Ethernet Unmanaged Switch (GS305)](https://www.amazon.com/gp/product/B07S98YLHM/ref=ppx_yo_dt_b_asin_image_o06_s00?ie=UTF8&psc=1)  

* 4x Ethernet Cables  
[Cat 6 Ethernet Cable, [6-Pack 1-ft]](https://www.amazon.com/gp/product/B01IQWGKQ6/ref=ppx_yo_dt_b_asin_image_o02_s00?ie=UTF8&psc=1)  

* 4x USB 2.0 to USB-C Cables  
[USB Type C Cable, [5-Pack 6-Inch] USB 2.0 to USB C](https://www.amazon.com/gp/product/B07MFZM8WZ/ref=ppx_yo_dt_b_asin_image_o04_s00?ie=UTF8&psc=1)  

* 1x USB Power Hub (Wall charger ok for small workload, make sure power to each port is sufficient)  
[USB Wall Charger, Anker 60W 6 Port USB Charging Station](https://www.amazon.com/gp/product/B00P936188/ref=ppx_yo_dt_b_asin_image_o04_s00?ie=UTF8&psc=1)  

* 1x Cluster Case (Not necessary, but gets confusing and very messy without)  
[iUniker Raspberry Pi 4 Cluster Case](https://www.amazon.com/gp/product/B07CTG5N3V/ref=ppx_yo_dt_b_asin_image_o05_s00?ie=UTF8&psc=1)  


# Setup  

Operating system: [Ubuntu Server 20.04.2 LTS for Raspberry Pi](https://ubuntu.com/download/raspberry-pi)  
There are multiple ways to download your image and flash your SD card. After downloading and flashing multiple times, I ended up using the link above to download my image.  
Regular [Ubuntu Server 20.04.2 LTS](https://ubuntu.com/download/server) is just fine.  Not quite sure of the difference between the Raspberry Pi specific image and this one, might be arm64 vs amd64 architechture.  This becomes significant when adding certain repos, such as with Kubernetes.

I then used [balenaEtcher](https://www.balena.io/etcher/) to flash my SD card using the MicroSD Reader that came with my Canakit.  

An alternative is [Raspberry Pi's Imager](https://www.raspberrypi.org/software/). You can either use your own downloaded image, or use an image provided by the application.  

# Git

git config --global user.name < username >  
git config --global user.email < email >  

## Set git to use the osxkeychain credential helper
git config --global credential.helper osxkeychain (Mac)    


# TODO:  
1. Test automation of docker-k8s-install
2. Ansible
3. Add pictures and code to document instructions  
4. Instructions pre script


:information_desk_person: [Markdown Guide](https://www.markdownguide.org/basic-syntax/)  


