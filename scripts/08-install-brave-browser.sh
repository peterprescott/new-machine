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

