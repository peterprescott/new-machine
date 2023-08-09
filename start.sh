#! /usr/bin/sh

#######################################
# Begin if not root
#######################################

start=$(date +%s)

# Check if the script is being run by the root user
if [ "$EUID" -eq 0 ]; then
    echo "This script should not be run as the root user."
    exit 1
fi

greeting=$(cat << EOF
\n
Hello $USER!\n
Let's get your new machine set up...
EOF
)
echo "$greeting"
#######################################


#######################################
# Silence virtual console default beep
#######################################

# Check if the service file exists
if ! sudo systemctl list-unit-files --type=service | grep -q 'silence-console.service'; then
    silencer=$(cat << EOF
[Unit]
Description=Silence virtual console default beep

[Service]
Type=oneshot
Environment=TERM=linux
StandardOutput=tty
TTYPath=/dev/console
ExecStart=/usr/bin/setterm -blength 0

[Install]
WantedBy=multi-user.target
EOF
    )

    sudo tee "/etc/systemd/system/silence-console.service" > /dev/null <<EOT
$silencer
EOT

    sudo systemctl daemon-reload
    sudo systemctl enable silence-console
    sudo systemctl start silence-console

    echo "Service silence-console created and started."
else
    echo "Service silence-console already exists. Skipping."
fi

#######################################


#######################################
# Pull dotfiles
#######################################

dotfiles_dir="$HOME/.dotfiles"

# Check if the ~/.dotfiles folder already exists
if ! type dotfiles; then
    git clone --bare https://github.com/"$USER"/.dotfiles.git "$HOME"/.dotfiles
    dotfiles_alias='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'
    eval $dotfiles_alias config --local status.showUntrackedFiles no
    eval $dotfiles_alias checkout
    echo "Dotfiles setup completed."
else
    echo "Dotfiles already installed. Skipping setup."
fi

#######################################


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

sudo apt update && sudo apt install -y "$packages"
chsh -s /usr/bin/zsh
sudo update-alternatives --set editor /usr/bin/nvim
sudo update-alternatives --set x-terminal-emulator /usr/bin/xterm

#######################################


#######################################
# Install vim-plug
#######################################

target_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [ ! -f "$target_path" ]; then
    sh -c 'curl -fLo "$target_path" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    echo "vim-plug installation completed."
else
    echo "vim-plug is already downloaded. Skipping installation."
fi

#######################################

#######################################
# Update Grub
#######################################

sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sudo update-grub

#######################################


#######################################
# Set up Ly
#######################################

if ! sudo systemctl list-unit-files --type=service | grep -q 'ly.service'; then
  git clone --recurse-submodules https://github.com/"$USER"/ly.git &&\
  cd ly
   make
   sudo make install installsystemd
   sudo systemctl enable ly.service
   sudo systemctl set-default graphical.target
   cd ..
  rm -rf ly
  echo "Service ly created and started."
else
  echo "Service ly already exists. Skipping."
fi

#######################################


#######################################
# Install Miniconda
#######################################

if ! type conda; then
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/install_miniconda.sh
  sh ~/install_miniconda.sh -b -u -p ~/.miniconda3
  rm -rf ~/install_miniconda.sh
  echo "Conda installed."
else
  echo "Conda already installed. Skipping."
fi

#######################################


#######################################
# Install Brave browser
#######################################

if ! type brave-browser; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser
  sudo update-alternatives --set x-www-browser /usr/bin/brave-browser-stable
  echo "Brave browser installed."
else
  echo "Brave browser already installed. Skipping."
fi

#######################################


#######################################
# Install Github CLI
#######################################

if ! type gh; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
  echo "Github CLI installed."
else
  echo "Github CLI already installed. Skipping."
fi

#######################################


#######################################
# Install Docker
#######################################

if ! type docker; then
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo service docker start
  sudo docker run hello-world
  sudo usermod -aG docker "$USER"
  echo "Docker installed."
else
  echo "Docker already installed. Skipping."
fi

#######################################


#######################################
# End with total time taken.
#######################################

end=$(date +%s)
total=$((end - start))
echo "Setup took $total seconds."

#######################################
