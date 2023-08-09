#######################################
# Set up Ly
#######################################
#
# output=$(sudo systemctl list-unit-files --type=service | grep -q 'ly.service')
# echo $output
# if ! $output; then
  git clone --recurse-submodules https://github.com/$1/ly.git &&\
  cd ly
   make
   sudo make install installsystemd
   sudo systemctl enable ly.service
   sudo systemctl set-default graphical.target
   cd ..
  rm -rf ly
  echo "Service ly created and started."
# else
#   echo "Service ly already exists. Skipping."
# fi

#######################################

