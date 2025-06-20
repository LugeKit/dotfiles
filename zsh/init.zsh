source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/prompt.zsh
source ~/dotfiles/zsh/completions.zsh
source ~/dotfiles/zsh/vim.zsh

# should be placed after vim
source ~/dotfiles/zsh/zsh-autopair/autopair.zsh
autopair-init

# shortcuts
alias ll='ls -l --color'
alias la='ls -la --color'
alias py3=python3

# git configuration
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.aa 'add --all'
git config --global alias.cm 'commit -m'
git config --global alias.ca 'commit --amend'
git config --global alias.can 'commit --amend --no-edit'
git config --global alias.st status
git config --global alias.r rebase
git config --global alias.rc 'rebase --continue'
git config --global alias.ra 'rebase --abort'
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
