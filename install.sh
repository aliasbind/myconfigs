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

# urxvt
URXVT_CONFIG_DIR=~/.config
ln -fs $INSTALLER_PATH/urxvt/Xresources ~/.Xresources
ln -fs $INSTALLER_PATH/urxvt/ $URXVT_CONFIG_DIR
xrdb ~/.Xresources
command -v xsel 2>&1 > /dev/null
if [ $? -ne 0 ]
then
	echo "Need to install xsel"
	sudo apt-get install -y xsel
fi

echo "urxvt: Success"

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

# zsh
ln -fs $INSTALLER_PATH/zshrc ~/.zshrc
git clone https://github.com/robbyrussel/oh-my-zsh.git ~/.oh-my-zsh
