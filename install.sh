#!/usr/bin/env bash

set -e

echo -e "\ninstalling config files to $HOME...\n"

# install vundle from git - vim package manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

src=$HOME/bash-tmux-vim

cp $src/.bashrc $HOME/
cp -r $src/.tmux/ $HOME/
cp $src/.tmux.conf.local $HOME/
cp -r $src/.vim/ $HOME/
cp $src/.vimrc $HOME/

ln -s -f .tmux/.tmux.conf $HOME/.tmux.conf

vim +PluginInstall +qall

echo -e "\ndone!\n"
