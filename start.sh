#!/bin/bash

# Define your dotfiles directory and home directory
DOTFILES_DIR="$HOME/.dotfiles"

# Check for zsh installation and install if not present
if ! command -v zsh &> /dev/null
then
    echo "Zsh is not installed. Installing zsh..."
    sudo apt-get update && sudo apt-get install zsh
else
    echo "Zsh is already installed."
fi

# Install oh-my-zsh for managing zsh configuration
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Set zsh as the default shell
if [ "$SHELL" != "/bin/zsh" ]
then
    echo "Setting zsh as the default shell..."
    chsh -s $(which zsh)
else
    echo "Zsh is already the default shell."
fi

echo "Installation and setup complete. Please log out and back in for default shell change to take effect."