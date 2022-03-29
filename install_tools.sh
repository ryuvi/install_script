#!/bin/bash

check_os() {
    OS=$1
    if [[ $OS == 'ARCH' ]];
    then
        EXEC='sudo pacman -Syyuu --noconfirm'
    else
        EXEC='sudo apt install -y'
    fi
}

check_os $1

# ----------------------- #
# INSTALL NORMAL PACKAGES #
# ----------------------- #

# INSTALL DEPENDENCIES
$EXEC curl

# INSTALL ZSH AND OH-MY-ZSH
$EXEC zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# THEME "refined"

# INSTALL NVIM
$EXEC neovim

# INSTALL GIT
$EXEC git

# INSTALL WINE
$EXEC wine

# INSTALL LUTRIS
$EXEC lutris

# INSTALL QBITTORRENT
$EXEC qbittorrent

# INSTALL EMACS
$EXEC emacs

# INSTALL VSCODE
$EXEC code

# INSTALL LUA
$EXEC lua



# -------------------- #
# INSTALL AUR PACKAGES #
# -------------------- #

# INSTALL VSCODIUM
# $EXEC vscodium-bin
