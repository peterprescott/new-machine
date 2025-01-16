git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo 
sudo systemctl enable keyd && sudo systemctl start keyd
sudo cp /home/peterprescott/new-machine/keyd_config/default.conf /etc/keyd/default.conf
rm -rf keyd
