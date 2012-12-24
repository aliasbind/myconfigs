#!/bin/bash

INSTALLER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# i3
I3_CONFIG_DIR=~/.i3
mkdir -p $I3_CONFIG_DIR
ln -fs $INSTALLER_PATH/i3/config $I3_CONFIG_DIR/config
echo -e "i3:\tSuccess"

# dunst
DUNST_CONFIG_DIR=~/.config/dunst
mkdir -p $DUNST_CONFIG_DIR
ln -fs $INSTALLER_PATH/dunst/dunstrc $DUNST_CONFIG_DIR/dunstrc
echo -e "dunst:\tSuccess"

# urxvt
URXVT_CONFIG_DIR=~/.config
ln -fs $INSTALLER_PATH/urxvt/Xresources ~/.Xresources
ln -fs $INSTALLER_PATH/urxvt/ $URXVT_CONFIG_DIR
xrdb ~/.Xresources
command -v xsel 2>&1 > /dev/null
if [ $? -ne 0 ]
then
	sudo apt-get install -y xsel
fi

echo -e "urxvt:\tSuccess"

# vim
if [ ! -d ~/.vim ]
then
	git clone --recursive git@github.com:aliasbind/vimconfig.git ~/.vim
	if [ $? -ne 0 ]
	then
		echo -e "vim:\tFailed to install configuration directory."
		exit 1
	fi
	ln -s ~/.vim/vimrc ~/.vimrc
	echo "vim:\tSuccess!"
else
	echo -e "vim:\tConfiguration was not installed because you already have"
	echo -e "\ta .vim directory in $HOME. Remove that directory"
	echo -e "\tand rerun this script to install this configuration."
fi

# zsh
ln -fs $INSTALLER_PATH/zshrc ~/.zshrc
if [ ! -d ~/.oh-my-zsh ]
then
	git clone https://github.com/robbyrussel/oh-my-zsh.git ~/.oh-my-zsh
	echo -e "zsh:\tSuccess"
else
	echo -e "zsh:\tzshrc file added, but oh-my-zsh is already installed"
fi
