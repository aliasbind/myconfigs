#!/bin/bash

INSTALLER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# i3
I3_CONFIG_DIR=~/.i3
mkdir -p $I3_CONFIG_DIR
ln -fs $INSTALLER_PATH/i3/config $I3_CONFIG_DIR/config
echo "i3: Success"

# dunst
DUNST_CONFIG_DIR=~/.config/dunst
mkdir -p $DUNST_CONFIG_DIR
ln -fs $INSTALLER_PATH/dunst/dunstrc $DUNST_CONFIG_DIR/dunstrc
echo "dunst: Success"

# Xresources
ln -fs $INSTALLER_PATH/Xresources ~/.Xresources
xrdb ~/.Xresources
echo "Xresources: Success"

# vim
if [ ! -d ~/.vim ]
then
	git clone --recursive git@github.com:aliasbind/vimconfig.git ~/.vim
	if [ $? -ne 0 ]
	then
		echo "Failed to install vim configuration."
		exit 1
	fi
	ln -s ~/.vim/vimrc ~/.vimrc
	echo "vim: Success!"
else
	echo "vim: Configuration was not installed because you already have"
	echo "a .vim directory in $HOME. Remove that directory and rerun"
	echo "this script to install this configuration."
fi
