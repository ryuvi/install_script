#!/bin/bash

doas pacman -S --noconfirm emacs ripgrep fd git
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
source ~/.emacs.d/bin/doom install

