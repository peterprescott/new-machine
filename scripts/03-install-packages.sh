#######################################
# Install essential packages from apt
#######################################

packages=$(cat << EOF

zsh
tmux
neovim
curl
w3m
tig
xserver-xorg-core
xinit
xterm
dmenu
i3
network-manager
build-essential
libpam0g-dev
libxcb-xkb-dev
ca-certificates 
gnupg
alsa-utils
pulseaudio
pavucontrol

EOF
)

sudo apt install -y $packages
chsh -s /usr/bin/zsh
sudo update-alternatives --set editor /usr/bin/nvim
sudo update-alternatives --set x-terminal-emulator /usr/bin/xterm

#######################################

