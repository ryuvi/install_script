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

install_hyper() {
    wget -c --content-disposition https://releases.hyper.is/download/AppImage

    mv Hyper*.AppImage $HOME/Applications
}

install_term() {
    echo -e "Which terminal emulator you want to use?\n [1] alacritty\n [2] tilix\n [3] xterm\n [4] hyper"
    read ANSWER

    case $ANSWER in
        1 || "alacritty") install_pckg $OSID alacritty ;;
        2 || "tilix") install_pckg $OSID tilix ;;
        3 || "xterm") install_pckg $OSID xterm ;;
        4 || "hyper") install_hyper ;;
    esac
}

install_dock() {
    echo -e "Which dock app you want to use?\n [1] plank\n [2] latte-dock"
    read ANSWER

    case $ANSWER in
        1 || "plank") install_pckg $OSID plank ;;
        2 || "latte-dock") install_pckg $OSID latte-dock ;;
    esac
}

install_texteditor() {
    echo -e "Which text editor you want to use?\n [1] vim\n [2] neovim\n [3] emacs"
    read $ANSWER

    case $ANSWER in
        1 || "vim") install_pckg $OSID vim ;;
        2 || "neovim") install_pckg $OSID neovim ;;
        3 || "emacs") install_pckg $OSID emacs ;;
    esac
}

# ----------------------- #
#    INSTALL PACKAGES     #
# ----------------------- #
OSID=`cat /etc/os-release | grep ID_LIKE | grep -o '[a-z]' | tr -d '\n'`

while read LINE; do
    INST_APP=`which $LINE`
    
    if [[ -n $INST_APP ]]
    then
        install_pckg $OSID $LINE
    fi

done < app_list;

gem install rails

install_term
install_dock
install_texteditor

# ----------------------- #
#     CALLING CONFIGS     #
# ----------------------- #
finish_oh-my-zsh
config_vim
