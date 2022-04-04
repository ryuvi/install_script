#!/bin/bash

# ----------------------- #
#        FUNCTIONS        #
# ----------------------- #
install_pckg() {
    OS=$1
    APP=$2

    echo "#####-#####-#####-#####-#####"
    echo "#####-#####-#####-#####-#####"
    echo "#####                   #####"
    echo "#####       $APP        #####"
    echo "#####                   #####"
    echo "#####-#####-#####-#####-#####"
    echo "#####-#####-#####-#####-#####"

    if [[ $OS == 'arch' ]]
    then

        sudo pacman -S --noconfirm $APP

    else

        sudo apt install -y $APP

    fi
}

finish_oh-my-zsh() {
    # INSTALL OH-MY-ZSH
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # INSTALL ZINIT
    sh -c "$(curl -fsSL https://git.io/zinit-install)"

    # SET SOME VARIABLES TO PUT ON .zshrc
    FAST_SYNTAX="zinit light zdharma-continuum/fast-syntax-highlighting"
    ZSH_AUTOSUGGESTIONS="zinit light zsh-users/zsh-autosuggestions"
    ZSH_COMPLETIONS="zinit light zsh-users/zsh-completions"

    # PUT THE VARIABLE ON .zshrc
    echo $FAST_SYNTAX >> $HOME/.zshrc
    echo $ZSH_AUTOSUGGESTIONS >> $HOME/.zshrc
    echo $ZSH_COMPLETIONS >> $HOME/.zshrc
}

config_vim() {
    # INSTALL ULTIMATE VIM
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
}

# ----------------------- #
#    INSTALL PACKAGES     #
# ----------------------- #
OSID=`cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

while read LINE; do

    install_pckg $OSID $LINE

done < app_list;

# ----------------------- #
#     CALLING CONFIGS     #
# ----------------------- #
finish_oh-my-zsh
config_vim
