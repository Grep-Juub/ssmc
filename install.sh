#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/Grep-Juub/ssmc/main/ssmc"

# Download the binary
sudo curl -s $REPO_URL -o /usr/local/bin/ssmc

# Make the binary executable
sudo chmod +x /usr/local/bin/ssmc

echo "Binary 'ssmc' installed to /usr/local/bin."

# Check if fzf is installed
if ! command -v fzf &>/dev/null; then
    echo "fzf is not installed. Installing now..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y fzf
        elif command -v yum &>/dev/null; then
            sudo yum install -y fzf
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y fzf
        else
            echo "Unsupported package manager. Please install fzf manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &>/dev/null; then
            brew install fzf
        else
            echo "Homebrew not found. Please install Homebrew or fzf manually."
            exit 1
        fi
    else
        echo "Unsupported OS type: $OSTYPE. Please install fzf manually."
        exit 1
    fi
    echo "fzf installation completed."
else
    echo "fzf is already installed."
fi

echo "Installation complete. Please restart your terminal or source your shell configuration file."
