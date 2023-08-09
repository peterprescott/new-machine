#! /bin/sh

apt install -y sudo

# Prompt for the username
read -p "Who needs sudo rights? " username

# Check if the user exists
if id "$username"; then
    # Add the user to the sudo group
    sudo usermod -aG sudo "$username"
    echo "Sudo rights granted to user $username."
else
    echo "User $username does not exist."
fi
