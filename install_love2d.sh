#!/bin/bash

OS=`sudo cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

if [[ $OS == "arch" ]]
then
    sudo pacman -S --noconfirm luajit \
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
    sudo apt install -y build-essential \
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

git clone https://github.com/love2d/love $HOME/Bin/love
cd $HOME/Bin/love
. ./platform/unix/automagic
. ./configure
make

