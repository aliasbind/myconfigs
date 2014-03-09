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

command -v xrdb &> /dev/null
if [ $? -ne 0 ]
then
	echo -e "urxvt:\tInstall package containing xrdb"
else
	xrdb ~/.Xresources
	command -v xsel &> /dev/null
	if [ $? -ne 0 ]
	then
		echo -e "urxvt:\tInstall package containing xsel"
	else
		echo -e "urxvt:\tSuccess"
	fi
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
else
	echo -e "vim:\tConfiguration was not installed because you already have"
	echo -e "\ta .vim directory in $HOME. Remove that directory"
	echo -e "\tand rerun this script to install this configuration."
fi

# zsh
ln -sf $INSTALLER_PATH/zshrc ~/.zshrc
if [ $? -ne 0 ]
then
	echo -e "zsh:\tFailed to install zshrc"
else
	if [ ! -d ~/.oh-my-zsh ]
	then
		git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
		echo -e "zsh:\tSuccess"
	else
		echo -e "zsh:\tzshrc file added, but oh-my-zsh is already installed"
	fi
fi

# gtk configs
ln -sf $INSTALLER_PATH/other/gtkrc-2.0 ~/.gtkrc-2.0
if [ $? -ne 0 ]
then
	echo -e "gtk2 config:\tFailed to create .gtkrc-2.0 link"
else
	echo -e "gtk2 config:\tSuccess"
fi

mkdir -p ~/.config/gtk-3.0/
ln -sf $INSTALLER_PATH/other/gtk3settings.ini ~/.config/gtk-3.0/settings.ini
if [ $? -ne 0 ]
then
	echo -e "gtk3 config:\tFailed to create settings.ini link"
else
	echo -e "gtk3 config:\tSuccess"
fi

# fonts.conf
mkdir -p ~/.config/fontconfig/
ln -sf $INSTALLER_PATH/other/fonts.conf ~/.config/fontconfig/fonts.conf
if [ $? -ne 0 ]
then
	echo -e "fonts.conf:\tFailed to create fonts.conf link"
else
	echo -e "fonts.conf:\tSuccess"
fi

# dircolors
ln -sf $INSTALLER_PATH/other/dircolors ~/.dircolors
if [ $? -ne 0 ]
then
	echo -e "dircolors:\tFailed to create .dircolors link"
else
	echo -e "dircolors:\tSuccess"
fi

# tigrc
ln -sf $INSTALLER_PATH/other/tigrc ~/.tigrc
if [ $? -ne 0 ]
then
	echo -e "tigrc:\tFailed to create .tigrc link"
else
	echo -e "tigrc:\tSuccess"
fi

# vimperatorrc
ln -sf $INSTALLER_PATH/other/vimperatorrc ~/.vimperatorrc
if [ $? -ne 0 ]
then
	echo -e "vimperatorrc:\tFailed to create .vimperatorrc link"
else
	echo -e "vimperatorrc:\tSuccess"
fi

# xinitrc
ln -sf $INSTALLER_PATH/other/xinitrc ~/.xinitrc
if [ $? -ne 0 ]
then
	echo -e "xinitrc:\tFailed to create .xinitrc link"
else
	echo -e "xinitrc:\tSuccess"
fi

# profile
ln -sf $INSTALLER_PATH/other/profile ~/.profile
if [ $? -ne 0 ]
then
	echo -e "profile:\tFailed to create .profile link"
else
	echo -e "profile:\tSuccess"
fi

# conkyrc
ln -sf $INSTALLER_PATH/other/conkyrc ~/.conkyrc
if [ $? -ne 0 ]
then
	echo -e "conkyrc:\tFailed to create .conkyrc link"
else
	echo -e "conkyrc:\tSuccess"
fi

# cgdb
mkdir -p ~/.cgdb/
ln -sf $INSTALLER_PATH/other/cgdbrc ~/.cgdb/cgdbrc
if [ $? -ne 0 ]
then
	echo -e "cgdbrc:\tFailed to create cgdbrc link"
else
	echo -e "cgdbrc:\tSuccess"
fi

# calcrc
ln -sf $INSTALLER_PATH/other/calcrc ~/.calcrc
if [ $? -ne 0 ]
then
	echo -e "calcrc:\tFailed to create calcrc link"
else
	echo -e "calcrc:\tSuccess"
fi

# mimelist
mkdir -p ~/.local/share/applications
ln -sf $INSTALLER_PATH/mime/mimeapps.list ~/.local/share/applications/
ln -sf $INSTALLER_PATH/mime/transmission-daemon.desktop ~/.local/share/applications/

# set Qt to use GTK themes
QT_CONFIG=~/.config/Trolltech.conf
QT_SETTING=$(cat << EOF
[Qt]
style=GTK+
EOF
)

grep 'style=GTK+' $QT_CONFIG &> /dev/null
if [ $? -ne 0 ]
then
	echo "$QT_SETTING" >> "$QT_CONFIG"
fi

# SYSTEM CONFIGURATION FILES

# Fix Xorg font path
sudo cp $INSTALLER_PATH/sysconfs/10-fontpath.conf /etc/X11/xorg.conf.d/

# Set keyboard layout to Romanian
sudo cp $INSTALLER_PATH/sysconfs/10-keyboard.conf /etc/X11/xorg.conf.d/

# slim.conf
sudo cp $INSTALLER_PATH/sysconfs/slim.conf /etc/slim.conf
