#!/bin/sh

PI_USER="ubuntu"
PI_PASS="ubuntu"
HOSTS=("192.168.1.99" "192.168.1.100" "192.168.1.101" "192.168.1.102")
USERNAMES=("master" "node1" "node2" "node3")
NEW_IPS=("192.168.1.150" "192.168.1.151" "192.168.1.152" "192.168.1.153")
NEW_PASS="k8s-pass"

# update + upgrade
for i in ${!HOSTS[*]} ; do
     echo "updating and upgrading"
     echo ${HOSTS[i]}
     sshpass -o StrictHostKeyChecking=no -p ${PI_PASS} ssh -l ${PI_USER} ${HOSTS[i]} <<EOF
      sudo apt update
      sudo apt -y upgrade && sudo systemctl reboot
     EOF
done

# set name
for i in ${!HOSTS[*]} ; do
     echo "set name"
     echo ${HOSTS[i]}
     sshpass -o StrictHostKeyChecking=no -p ${PI_PASS} ssh -l ${PI_USER} ${HOSTS[i]} <<EOF
      #command_one
      #command_two
      #command_three
     EOF
done

# set static IP
for i in ${!HOSTS[*]} ; do
     echo "set static IP"
     echo ${HOSTS[i]}
     sshpass -o StrictHostKeyChecking=no -p ${NEW_PASS} ssh -l ${USERNAMES[i]} ${HOSTS[i]} <<-EOF1
          cat > /etc/netplan/50-cloud-init.yaml <<-EOF2
               network:
                 version: 2
                 renderer: networkd
                 ethernets:
                   eth0:
                    dhcp4: no
                    addresses: [${NEW_IPS[i]/24]
                    gateway4: 192.168.0.1
                    nameservers:
                      addresses: [8.8.8.8,8.8.4.4]
          EOF2
     EOF1
done
