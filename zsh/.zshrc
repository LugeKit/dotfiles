autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git*' formats '(%b)'
PROMPT='%F{red}%n%f %F{blue}%~%f%F{green}${vcs_info_msg_0_}%f> '

alias ll='ls -l'
alias la='ls -la'

# git configuration
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.aa 'add --all'
git config --global alias.cm 'commit -m'
git config --global alias.st status
git config --global push.autoSetupRemote true

function gpw {
    git aa
    git commit --amend --no-edit
    git push -f
}
