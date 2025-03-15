cd ~/dotfiles && git submodule init && git submodule update
if [ $? -ne 0 ]; then
    echo "Error: failed to init git submodule, please check your network or dotfiles path"
    exit 1
fi

echo 'source ~/dotfiles/vim/init.vimrc' >> ~/.vimrc
echo 'source ~/dotfiles/zsh/init.zsh' >> ~/.zshrc

mkdir -p ~/.config/ghostty && ln -s ~/dotfiles/ghostty/config ~/.config/ghostty/config 
mkdir -p ~/.hammerspoon && ln -s ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

echo "Init successfully, please reopen your terminal"
