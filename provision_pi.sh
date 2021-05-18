#!/bin/sh

PI_USER="ubuntu"
PI_PASS="ubuntu"
HOSTS=("192.168.1.99" "192.168.1.100" "192.168.1.101" "192.168.1.102")
USERNAMES=("master" "node1" "node2" "node3")
NEW_IPS=("192.168.1.150" "192.168.1.151" "192.168.1.152" "192.168.1.153")
NEW_PASS="k8s-pass"
for i in ${!HOSTS[*]} ; do
     echo ${HOSTS[i]}
     SCR=${PASSWORD/${PASSWORDS[i]}}
     sshpass -p ${PI_PASS} ssh -l ${PI_USER} ${HOSTS[i]} "${SCR}" <<EOF
      #command_one
      #command_two
      #command_three
     EOF
done
