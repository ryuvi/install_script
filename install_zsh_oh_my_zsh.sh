#!/bin/bash

# INSTALL ZSH IN CASE IS NOT INSTALLED
pacman -S --noconfirm zsh

# INSTALL OH-MY-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# INSTALL ZINIT
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# PUT THE PLUGINS
echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> $HOME/.zshrc
echo "zinit light zsh-users/zsh-autosuggestions" >> $HOME/.zshrc
echo "zinit light zsh-users/zsh-completions" >> $HOME/.zshrc

