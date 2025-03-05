# use CTRL-D to enter normal mode, because there will be a lag when using escape
# should be placed BEFORE zsh-syntax-highlighting/zsh-autosuggestions is loaded
VIM_MODE_VICMD_KEY='^D'
# vim input in zsh, should behind zsh-syntax-highlighting
source ~/dotfiles/zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
