
#######################################
# Install vim-plug
#######################################

target_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [ ! -f $target_path ]; then
    sh -c 'curl -fLo "$target_path" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    echo "vim-plug installation completed."
else
    echo "vim-plug is already downloaded. Skipping installation."
fi

#######################################

