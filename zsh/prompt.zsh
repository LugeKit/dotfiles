source ~/dotfiles/zsh/git-prompt/git-prompt.zsh
source ~/dotfiles/zsh/git-prompt/examples/ascii.zsh
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
gitprompt_modify() {
    local prompt=$(gitprompt)
    if [[ $prompt == "" ]]; then
        echo " > "
    else
        echo "[$prompt] > "
    fi
}
PROMPT='%F{red}%n%f %F{blue}%1~%f$(gitprompt_modify)'
