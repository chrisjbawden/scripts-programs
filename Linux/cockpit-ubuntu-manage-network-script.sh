sudo apt update
sudo apt install network-manager
sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service

sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf


#sudo sed -i '/^network:/a\  renderer: NetworkManager' /etc/netplan/00-*.yaml
#cat /etc/netplan/00-*.yaml
sudo rm /etc/netplan/00-*.yaml

echo ""
echo ""
echo "Please reboot to apply"
