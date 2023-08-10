#! /bin/sh

apt install -y sudo

if $1; then
  username=$1
else
  read -p "Who needs sudo rights? " username
fi

# Check if the user exists
if id "$username"; then
    # Add the user to the sudo group
    sudo usermod -aG sudo "$username"
    echo "Sudo rights granted to user $username."
else
    echo "User $username does not exist."
fi
