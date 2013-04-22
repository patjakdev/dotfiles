#!/bin/bash
##############################
# setup.sh
# Sets up dotfiles environment
##############################

dir=~/dotfiles
olddir=~/dotfiles_old

mkdir -p $olddir

shopt -s nullglob
dirname=`dirname $0`
basename=`basename $0`
for f in $dirname/*
do
    if [ "$f" != "$0" ]
    then
        existing=~/.`basename $f`
        if [ -f $existing ]
        then
            mv $existing $olddir
            echo "Saved $existing to $olddir"
        fi
        ln -s $existing $f
    fi
done
