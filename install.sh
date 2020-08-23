#!/usr/bin/env bash
#cp -r !(.git|.gitignore|README.md|install.sh) $HOME

src=$HOME/bash-tmux-vim

cp $src/.bashrc $HOME/
cp -r $src/.tmux/ $HOME/
cp $src/.tmux.conf.local $HOME/
cp -r $src/.vim/ $HOME/
cp $src/.vimrc $HOME/

ln -s -f .tmux/.tmux.conf $HOME/.tmux.conf
