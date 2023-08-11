wget https://zoom.us/client/5.15.7.6521/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
sudo apt --fix-broken install
sudo apt install -y ./zoom_amd64.deb
rm ./zoom_amd64.deb

# or try https://zoom.us/download?os=linux
