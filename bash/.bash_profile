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
