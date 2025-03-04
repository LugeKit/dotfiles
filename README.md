put folder `dotfiles` under `$HOME`

# hammerspoon
```bash
rm ~/.hammerspoon/init.lua
ln -s ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua
```

# zsh
```bash
echo 'source ~/dotfiles/zsh/.zshrc` >> ~/.zshrc
```

# vim
```bash
echo 'source ~/dotfiles/vim/init.vimrc' >> ~/.vimrc
```
