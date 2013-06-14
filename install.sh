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
	echo "urxvt:\tInstall package containing xsel"
else
	echo -e "urxvt:\tSuccess"
fi

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
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	echo -e "zsh:\tSuccess"
else
	echo -e "zsh:\tzshrc file added, but oh-my-zsh is already installed"
fi

# other
ln -sf $INSTALLER_PATH/other/gtkrc-2.0 ~/.gtkrc-2.0

mkdir -p ~/.config/gtk-3.0/
ln -sf $INSTALLER_PATH/other/gtk3settings.ini ~/.config/gtk-3.0/settings.ini

mkdir -p ~/.config/fontconfig/
ln -sf $INSTALLER_PATH/other/fonts.conf ~/.config/fontconfig/fonts.conf

# dircolors
ln -sf $INSTALLER_PATH/other/dircolors ~/.dircolors
