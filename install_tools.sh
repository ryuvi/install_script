#!/bin/bash

# ----------------------- #
#                         #
#        OS SETTER        #
#                         #
# ----------------------- #
OS=`sudo cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

if [[ $OS == 'arch' ]]; then
    INSTALLER="sudo pacman -S --noconfirm"
    sudo pacman -Syyuu --noconfirm
else
    INSTALLER="sudo apt install -y"
    sudo apt upgrade -y
fi

if [[ ! -e $HOME/Applications ]]
then
    mkdir $HOME/Applications
fi

# ---------------------------------- #
#                                    #
#        STANDARD ENVIRONMENT        #
#                                    #
# ---------------------------------- #
$INSTALLER curl \
    wget \
    vim \
    git \
    ttf-fira-code \
    base-devel



# ----------------------------- #
#                               #
#        ZSH ENVIRONMENT        #
#                               #
# ----------------------------- #
$INSTALLER zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://git.io/zinit-install)"

echo "Inserting the zinit configuration on .zshrc ..."
echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> $HOME/.zshrc
echo "zinit light zsh-users/zsh-autosuggestions" >> $HOME/.zshrc
echo "zinit light zsh-users/zsh-completions" >> $HOME/.zshrc



# --------------------------------------- #
#                                         #
#        TEXT EDITOR CONFIGURATION        #
#                                         #
# --------------------------------------- #
echo -e "Which text editor you want to use?\n [1] vim\n [2] neovim\n [3] emacs"
read TEXT_EDITOR_ANSWER

case $TEXT_EDITOR_ANSWER in

    1 | "vim")
        $INSTALLER vim
        git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
        sh ~/.vim_runtime/install_awesome_vimrc.sh
        ;;

    2 | "neovim") $INSTALLER neovim ;;
    3 | "emacs") $INSTALLER emacs ;;

esac

$INSTALLER code

wget -c --content-disposition https://github.com/lite-xl/lite-xl/releases/latest/download/LiteXL-x86_64.AppImage
mv LiteXL-*.AppImage $HOME/Applications


# -------------------------------- #
#                                  #
#        TERM CONFIGURATION        #
#                                  #
# -------------------------------- #
echo -e "Which terminal emulator you want to use?\n [1] alacritty\n [2] tilix\n [3] xterm\n [4] hyper"
read TERM_ANSWER

case $TERM_ANSWER in

    1 | "alacritty") $INSTALLER alacritty ;;
    2 | "tilix") $INSTALLER tilix ;;
    3 | "xterm") $INSTALLER xterm ;;
    4 | "hyper")
        wget -c --content-disposition https://releases.hyper.is/download/AppImage
        mv Hyper*.AppImage $HOME/Applications
    ;;

esac



# -------------------------------- #
#                                  #
#        DOCK CONFIGURATION        #
#                                  #
# -------------------------------- #
echo -e "Which dock app you want to use?\n [1] plank\n [2] latte-dock"
read DOCK_ANSWER

case $DOCK_ANSWER in

    1 | "plank") $INSTALLER plank ;;
    2 | "latte-dock") $INSTALLER latte-dock ;;

esac



# -------------------------------- #
#                                  #
#        JAVA CONFIGURATION        #
#                                  #
# -------------------------------- #
$INSTALLER jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src



# -------------------------------- #
#                                  #
#         PHP CONFIGURATION        #
#                                  #
# -------------------------------- #
$INSTALLER apache php php-apache phpmyadmin



# ------------------------------------ #
#                                      #
#        DATABASE CONFIGURATION        #
#                                      #
# ------------------------------------ #
$INSTALLER mysql sqlite3



# -------------------------------------- #
#                                        #
#        JAVASCRIPT CONFIGURATION        #
#                                        #
# -------------------------------------- #
$INSTALLER nodejs yarn



# --------------------------------------- #
#                                         #
#        PROGRAMMING CONFIGURATION        #
#                                         #
# --------------------------------------- #
$INSTALLER lua \
    go \
    docker \
    docker-compose \
    ruby \
    filezilla \
    python3 \
    nasm \
    bochs \
    redis

gem install rails



# LOVE
git clone https://github.com/love2d/love

if [[ $OS == "arch" ]]
then
    $INSTALLER luajit \
    freetype2 \
    mpg123 \
    openal \
    libvorbis \
    libtheora \
    libmodplug \
    sdl2 \
    shared-mime-info \
    hicolor-icon-theme \
    desktop-file-utils

else
    $INSTALLER build-essential \
    autotools-dev \
    automake libtool \
    pkg-config \
    libfreetype6-dev \
    libluajit-5.1-dev \
    libphysfs-dev \
    libsdl2-dev \
    libopenal-dev \
    libogg-dev \
    libvorbis-dev \
    libmodplug-dev \
    libmpg123-dev \
    libtheora-dev
fi

cd love
./platform/unix/automagic
./configure
make



# --------------------------------------- #
#                                         #
#        MISCELLANEA CONFIGURATION        #
#                                         #
# --------------------------------------- #
$INSTALLER wine \
    lutris \
    qbittorrent \
    peek \
    steam

