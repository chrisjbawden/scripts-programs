#!/bin/bash
clear
if [ -f "/usr/share/dwagent/native/uninstall" ]; then 
    echo DWService Agent already installed.
    read -p 'Uninstall (y/n)? ' uins
    if [[ "$uins" == *"yes"* ]]; then
         clear
         sudo bash /usr/share/dwagent/native/uninstall
         fi
fi

clear
sudo apt update
clear
apt install python3.8
clear
apt install wget
wget
if [ -f "dwagent_generic.sh" ]; then 
clear
echo
read  -p 'Enter username: ' uname
echo
read -p 'Enter password: ' pword
echo
read -p 'Enter name of agent: ' nme
clear
echo
bash dwagent_generic.sh -silent user=$uname password=$pword name=$nme
else 
wget https://www.dwservice.net/download/dwagent_generic.sh
clear
echo
read  -p 'Enter username: ' uname
echo
read -p 'Enter password: ' pword
echo
read -p 'Enter name of agent: ' nme
clear
echo
bash dwagent_generic.sh -silent user=$uname password=$pword name=$nme
fi

