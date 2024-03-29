#!/bin/bash
clear
if [ -f "/usr/share/dwagent/native/uninstall" ]; then 
echo 
echo DWService Agent already installed.
echo 
read -p 'Uninstall (y/n)? ' uins
if [[ "$uins" == *"yes"* ]]; then
clear
echo
sudo bash /usr/share/dwagent/native/uninstall -1
./usr/share/dwagent/native/dwagsvc start
exit 0
fi
if [[ "$uins" == *"y"* ]]; then
clear
echo
sudo bash /usr/share/dwagent/native/uninstall -1
./usr/share/dwagent/native/dwagsvc start
exit 0
fi
fi

clear
sudo apt update
clear
apt install python3.8 -y
clear
apt install wget -y
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
rm dwa*
crontab -l | { cat; echo "@reboot sleep 60; ./usr/share/dwagent/native/dwagsvc start"; } | crontab -

fi
