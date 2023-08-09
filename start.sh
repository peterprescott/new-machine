#! /usr/bin/sh

#######################################
# Begin if not root
#######################################

start=$(date +%s)

# Check if the script is being run by the root user
if "$USER" -eq "root"; then
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
# Run setup scripts
#######################################

cd $HOME
scripts="$HOME/new-machine/scripts"
sh $scripts/01-pull-dotfiles.sh $USER $HOME
sudo sh $scripts/02-install-packages.sh $USER $HOME
sh $scripts/03-get-vimplug.sh  $USER $HOME $XDG_DATA_HOME
sudo sh $scripts/04-update-grub.sh $USER $HOME
sudo sh $scripts/05-setup-ly.sh  $USER $HOME
sudo sh $scripts/06-silence-console.sh $USER $HOME
sh $scripts/07-install-miniconda.sh $USER $HOME
sudo sh $scripts/08-install-brave-browser.sh $USER $HOME
sudo sh $scripts/09-install-gh-cli.sh $USER $HOME
sudo sh $scripts/10-install-docker.sh  $USER $HOME
sudo sh $scripts/11-connect-wifi.sh

#######################################


#######################################
# End with total time taken.
#######################################

end=$(date +%s)
total=$((end - start))
echo "Setup took $total seconds."

#######################################
