
#######################################
# Pull dotfiles
#######################################

dotfiles_dir="$HOME/.dotfiles"

# Check if the ~/.dotfiles folder already exists
if ! type dotfiles; then
    git clone --bare https://github.com/"$USER"/.dotfiles.git $HOME/.dotfiles
    dotfiles_alias='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'
    eval $dotfiles_alias config --local status.showUntrackedFiles no
    eval $dotfiles_alias checkout
    echo "Dotfiles setup completed."
else
    echo "Dotfiles already installed. Skipping setup."
fi

#######################################

