#!/bin/bash

# Default Dotfiles Directory (Current Directory)
DEFAULT_DOTFILES_DIR=$(pwd)
read -p "Enter dotfiles path [${DEFAULT_DOTFILES_DIR}]: " DOTFILES_DIR
DOTFILES_DIR=${DOTFILES_DIR:-$DEFAULT_DOTFILES_DIR}
# Expand tilde if present
DOTFILES_DIR="${DOTFILES_DIR/#\~/$HOME}"

# Default Vimrc Path
DEFAULT_VIMRC="$HOME/.vimrc"
read -p "Enter .vimrc path [${DEFAULT_VIMRC}]: " VIMRC_PATH
VIMRC_PATH=${VIMRC_PATH:-$DEFAULT_VIMRC}
VIMRC_PATH="${VIMRC_PATH/#\~/$HOME}"

# Default Zshrc Path
DEFAULT_ZSHRC="$HOME/.zshrc"
read -p "Enter .zshrc path [${DEFAULT_ZSHRC}]: " ZSHRC_PATH
ZSHRC_PATH=${ZSHRC_PATH:-$DEFAULT_ZSHRC}
ZSHRC_PATH="${ZSHRC_PATH/#\~/$HOME}"

# Default Ghostty Config Dir
DEFAULT_GHOSTTY="$HOME/.config/ghostty"
read -p "Enter Ghostty config dir [${DEFAULT_GHOSTTY}]: " GHOSTTY_DIR
GHOSTTY_DIR=${GHOSTTY_DIR:-$DEFAULT_GHOSTTY}
GHOSTTY_DIR="${GHOSTTY_DIR/#\~/$HOME}"

# Default Hammerspoon Dir
DEFAULT_HAMMERSPOON="$HOME/.hammerspoon"
read -p "Enter Hammerspoon dir [${DEFAULT_HAMMERSPOON}]: " HAMMERSPOON_DIR
HAMMERSPOON_DIR=${HAMMERSPOON_DIR:-$DEFAULT_HAMMERSPOON}
HAMMERSPOON_DIR="${HAMMERSPOON_DIR/#\~/$HOME}"


echo ""
echo "----------------------------------------------------------------"
echo "Configuration Summary:"
echo "Dotfiles Dir:    $DOTFILES_DIR"
echo "Vimrc Path:      $VIMRC_PATH"
echo "Zshrc Path:      $ZSHRC_PATH"
echo "Ghostty Dir:     $GHOSTTY_DIR"
echo "Hammerspoon Dir: $HAMMERSPOON_DIR"
echo "----------------------------------------------------------------"
echo ""

read -p "Press Enter to continue setup or Ctrl+C to cancel..."

cd "$DOTFILES_DIR" && git submodule init && git submodule update
if [ $? -ne 0 ]; then
    echo "Error: failed to init git submodule, please check your network or dotfiles path"
    exit 1
fi

echo "source $DOTFILES_DIR/vim/init.vimrc" >> "$VIMRC_PATH"
echo "source $DOTFILES_DIR/zsh/init.zsh" >> "$ZSHRC_PATH"

mkdir -p "$GHOSTTY_DIR" && ln -s "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_DIR/config"
mkdir -p "$HAMMERSPOON_DIR" && ln -s "$DOTFILES_DIR/hammerspoon/init.lua" "$HAMMERSPOON_DIR/init.lua"

echo "Init successfully, please reopen your terminal"
