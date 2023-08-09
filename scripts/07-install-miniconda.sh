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

