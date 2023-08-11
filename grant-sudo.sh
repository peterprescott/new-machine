#! /bin/sh

apt install -y sudo

username=$1

# Check if the user exists
if id "$username"; then
    # Add the user to the sudo group
    sudo usermod -aG sudo "$username"
else
    echo "User $username does not exist."
fi
