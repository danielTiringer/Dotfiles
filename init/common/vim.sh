#!/bin/sh
# Install the Vundle plugin manager

if [ ! -x "$HOME"/.vim/bundle ] ; then
	mkir "$HOME"/.vim/bundle
fi

if [ ! -x "$HOME"/.vim/bundle/Vundle.vim ] ; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
