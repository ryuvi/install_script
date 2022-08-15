#!/bin/bash

# flutter
git clone https://aur.archlinux.org/flutter.git
cd flutter
makepkg -si
cd ..

sudo gpasswd -a ryuvi flutterusers
