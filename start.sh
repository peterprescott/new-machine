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

cd ~
scripts="$(pwd)/new-machine/scripts"
sudo sh $scripts/01-silence-console.sh
sudo sh $scripts/02-pull-dotfiles.sh
sudo sh $scripts/03-install-packages.sh
sudo sh $scripts/04-get-vimplug.sh
sudo sh $scripts/05-update-grub.sh
sudo sh $scripts/06-setup-ly.sh
sudo sh $scripts/07-install-miniconda.sh
sudo sh $scripts/08-install-brave-browser.sh
sudo sh $scripts/09-install-gh-cli.sh
sudo sh $scripts/10-install-docker.sh

#######################################


#######################################
# End with total time taken.
#######################################

end=$(date +%s)
total=$((end - start))
echo "Setup took $total seconds."

#######################################
