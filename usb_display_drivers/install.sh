sudo apt update
sudo apt install dkms libdrm-dev linux-headers-$(uname -r)

wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb

sudo apt install ./synaptics-repository-keyring.deb

sudo apt update

sudo apt install displaylink-driver
