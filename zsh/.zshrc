HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHAREHISTORY
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/prompt.zsh

# use CTRL-D to enter normal mode, because there will be a lag when using escape
# should be placed before plugin is loaded
VIM_MODE_VICMD_KEY='^D'
# vim input in zsh, should behind zsh-syntax-highlighting
source ~/dotfiles/zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh

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
