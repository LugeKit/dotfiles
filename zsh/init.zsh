source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/prompt.zsh
source ~/dotfiles/zsh/completions.zsh
source ~/dotfiles/zsh/vim.zsh

# should be placed after vim
source ~/dotfiles/zsh/zsh-autopair/autopair.zsh
autopair-init

# shortcuts
alias ll='ls -l'
alias la='ls -la'
alias py3=python3

# git configuration
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.aa 'add --all'
git config --global alias.cm 'commit -m'
git config --global alias.st status
git config --global push.autoSetupRemote true

gpw() {
    git aa
    git commit --amend --no-edit
    git push -f
}

grs() {
    git aa
    git reset --hard head
}
