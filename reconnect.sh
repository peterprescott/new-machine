#!/bin/bash

sudo systemctl disable wpa_supplicant
sudo systemctl stop wpa_supplicant

sudo iwconfig wlp58s0 power off

sudo ip link set wlp58s0 down
sudo ip link set wlp58s0 up


