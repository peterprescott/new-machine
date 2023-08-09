#! /bin/sh

read -p "Wifi network name?" network
sudo nmcli --ask dev wifi connect $network
