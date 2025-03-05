# history between sessions for auto suggestions
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHAREHISTORY
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

# completions settings
# link: https://thevaluable.dev/zsh-completion-guide-examples/
autoload -U compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes true
