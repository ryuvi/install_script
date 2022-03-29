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

# ----------------------- #
#    INSTALL PACKAGES     #
# ----------------------- #
OSID=`cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

while read LINE; do
    
    install_pckg $OSID $LINE

done < app_list;
