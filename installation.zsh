#!/bin/zsh

# Define the directories
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup"
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"

# Ensure the existence of Oh My Zsh and custom directories
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Ensure the custom plugin directory exists
mkdir -p "$PLUGINS_DIR"
mkdir -p "$THEMES_DIR"

# Function to install a Zsh plugin
install_plugin() {
    local url="$1"
    local plugin_dir="$2"
    local plugin_name="${url:t:r}"

    if [[ ! -d "$plugin_dir/$plugin_name" ]]; then
        echo "Installing $plugin_name..."
        git clone "$url" "$plugin_dir/$plugin_name"
    else
        echo "$plugin_name is already installed."
    fi
}

# Install plugins using the function
install_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR"
install_plugin https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR"

# Install Powerlevel10k theme
if [[ ! -d "$THEMES_DIR/powerlevel10k" ]]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
else
    echo "Powerlevel10k is already installed."
fi

# Append plugins to your .zshrc if not already there
if ! grep -q "zsh-syntax-highlighting" "$HOME/.zshrc"; then
    echo "source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    echo "source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$HOME/.zshrc"
fi

# Set Powerlevel10k theme in .zshrc if not already set
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$HOME/.zshrc"; then
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$HOME/.zshrc"
fi

echo "Configuration updated. Reload your terminal or source your .zshrc to see the changes."


# Install neovim
 curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
 sudo rm -rf /opt/nvim
 sudo tar -C /opt -xzf nvim-linux64.tar.gz
 echo export PATH="$PATH:/opt/nvim-linux64/bin" >> ~/.zshrc
