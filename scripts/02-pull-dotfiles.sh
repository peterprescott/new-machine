
#######################################
# Pull dotfiles
#######################################

dotfiles_dir="$2/.dotfiles"

# Check if the ~/.dotfiles folder already exists
if ! type dotfiles; then
    git clone --bare https://github.com/$1/.dotfiles.git $2/.dotfiles
    dotfiles_alias='/usr/bin/git --git-dir=$2/.dotfiles/ --work-tree=$2'
    eval $dotfiles_alias config --local status.showUntrackedFiles no
    eval $dotfiles_alias checkout
    echo "Dotfiles setup completed."
else
    echo "Dotfiles already installed. Skipping setup."
fi

#######################################

