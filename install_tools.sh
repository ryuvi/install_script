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
    
    FAST_SYNTAX="zinit light zdharma-continuum/fast-syntax-highlighting"
    ZSH_AUTOSUGGESTIONS="zinit light zsh-users/zsh-autosuggestions"
    ZSH_COMPLETIONS="zinit light zsh-users/zsh-completions"
    
    echo $FAST_SYNTAX >> $HOME/.zshrc
    echo $ZSH_AUTOSUGGESTIONS >> $HOME/.zshrc
    echo $ZSH_COMPLETIONS >> $HOME/.zshrc
}

# ----------------------- #
#    INSTALL PACKAGES     #
# ----------------------- #
OSID=`cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

while read LINE; do
    
    install_pckg $OSID $LINE

done < app_list;
