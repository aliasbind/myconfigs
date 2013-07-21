#!/bin/bash

TARGZ=mail.tar.gz
INSTALLER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ~

if [[ $# -ne 1 || ($1 != "-u" && $1 != "-p") ]]
then
    echo "Usage: $0 -u | -p"
    exit 1
fi

if [ $1 == "-u" ]
then
    echo Unpacking...
    gpg -d $INSTALLER_PATH/$TARGZ.gpg
    atool -x -f $INSTALLER_PATH/$TARGZ
    exit
else
    echo Packing...
    if [ -f $INSTALLER_PATH/$TARGZ ]
    then
        rm -i $INSTALLER_PATH/$TARGZ
    fi

    if [ -f $INSTALLER_PATH/$TARGZ ]
    then
        echo "Aborting. Remove $TARGZ and try again."
        exit 1
    fi

    atool -a .$TARGZ \
        .offlineimap/work.pwd.gpg .offlineimaprc .offlineimap.py \
        .mutt/ \
        .gnupg/{{secring,pubring}.gpg,gpg.conf}

    if [ $? -ne 0 ]
    then
        rm -f .$TARGZ
        exit 1
    fi

    mv .$TARGZ $INSTALLER_PATH/$TARGZ
    gpg --yes -c $INSTALLER_PATH/$TARGZ
    rm $INSTALLER_PATH/$TARGZ
fi

# vim: et: sw=4: ts=4
