#######################################
# Update Grub
#######################################

sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sudo update-grub

#######################################

