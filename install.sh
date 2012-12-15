#!/bin/bash

INSTALLER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# i3
I3_CONFIG_DIR=~/.i3
mkdir -p $I3_CONFIG_DIR
ln -fs $INSTALLER_PATH/i3/config $I3_CONFIG_DIR/config

# dunst
DUNST_CONFIG_DIR=~/.config/dunst
mkdir -p $DUNST_CONFIG_DIR
ln -fs $INSTALLER_PATH/dunst/dunstrc $DUNST_CONFIG_DIR/dunstrc

# Xresources
ln -fs $INSTALLER_PATH/Xresources ~/.Xresources
xrdb ~/.Xresources

# vim
command -v git > /dev/null
if [ $? -ne 0 ]
then
	sudo apt-get install git
fi

git clone git@github.com:aliasbind/vimconfig.git ~/.vim
if [ $? -ne 0 ]
then
	echo "Failed to install vim configuration."
	exit 1
fi
ln -s ~/.vim/vimrc ~/.vimrc
