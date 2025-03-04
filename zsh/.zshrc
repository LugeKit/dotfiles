# setup prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git*' formats '(%b)'
PROMPT='%F{red}%n%f %F{blue}%~%f%F{green}${vcs_info_msg_0_}%f> '

# command highlight
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
