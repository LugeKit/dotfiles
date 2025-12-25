#!/bin/bash

# Helper function to get path input
get_path() {
    local desc=$1
    local default=$2
    local path

    read -p "Enter $desc [$default]: " path
    path=${path:-$default}
    # Expand tilde if present
    echo "${path/#\~/$HOME}"
}

# Helper function to confirm action
# Returns 0 (true) if user confirms, 1 (false) otherwise
confirm() {
    local prompt=$1
    local response
    read -p "$prompt [Y/n/space to skip]: " response
    # Default to Yes if empty, accept Y/y. Reject others (n, space, etc.)
    if [[ -z "$response" || "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Helper function to append configuration to a file
append_config() {
    local file_path=$1
    local source_line=$2
    
    if [ -f "$file_path" ]; then
        if grep -qF "$source_line" "$file_path"; then
            echo "Configuration already present in $file_path"
        else
            echo "$source_line" >> "$file_path"
            echo "Configuration added to $file_path"
        fi
    else
        # Create directory path if it doesn't exist (e.g. for .config/file)
        mkdir -p "$(dirname "$file_path")"
        echo "$source_line" >> "$file_path"
        echo "Created $file_path and added configuration."
    fi
}

# Helper function to create symlink safely
link_config() {
    local target_dir=$1
    local link_name=$2
    local source_path=$3

    mkdir -p "$target_dir"
    local target_path="$target_dir/$link_name"
    
    if [ -L "$target_path" ]; then
        echo "Symlink $target_path already exists."
    elif [ -e "$target_path" ]; then
        echo "Warning: $target_path exists and is not a symlink. Skipping."
    else
        ln -s "$source_path" "$target_path"
        echo "Linked $source_path to $target_path"
    fi
}

# --- Configuration Setup ---

echo "Configuration Setup..."
DOTFILES_DIR=$(get_path "dotfiles path" "$(pwd)")
VIMRC_PATH=$(get_path ".vimrc path" "$HOME/.vimrc")
ZSHRC_PATH=$(get_path ".zshrc path" "$HOME/.zshrc")
GHOSTTY_DIR=$(get_path "Ghostty config dir" "$HOME/.config/ghostty")
HAMMERSPOON_DIR=$(get_path "Hammerspoon dir" "$HOME/.hammerspoon")

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

if ! confirm "Proceed with installation?"; then
    echo "Installation cancelled."
    exit 0
fi

# --- Installation Steps ---

# 1. Git Submodules
if confirm "Initialize git submodules?"; then
    cd "$DOTFILES_DIR" && git submodule init && git submodule update
    if [ $? -ne 0 ]; then
        echo "Error: failed to init git submodule, please check your network or dotfiles path"
    fi
fi

# 2. Vim Configuration
if confirm "Configure Vim?"; then
    append_config "$VIMRC_PATH" "source $DOTFILES_DIR/vim/init.vimrc"
fi

# 3. Zsh Configuration
if confirm "Configure Zsh?"; then
    append_config "$ZSHRC_PATH" "source $DOTFILES_DIR/zsh/init.zsh"
fi

# 4. Ghostty Configuration
if confirm "Configure Ghostty?"; then
    link_config "$GHOSTTY_DIR" "config" "$DOTFILES_DIR/ghostty/config"
fi

# 5. Hammerspoon Configuration
OS="$(uname -s)"
# Check for Windows environments (MINGW, CYGWIN, MSYS)
if [[ "$OS" == *"MINGW"* || "$OS" == *"CYGWIN"* || "$OS" == *"MSYS"* ]]; then
    echo "Windows detected. Skipping Hammerspoon configuration."
else
    if confirm "Configure Hammerspoon?"; then
        link_config "$HAMMERSPOON_DIR" "init.lua" "$DOTFILES_DIR/hammerspoon/init.lua"
    fi
fi

echo ""
echo "Setup process completed. Please reopen your terminal."
