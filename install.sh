#!/usr/bin/env bash

src=$HOME/bash-tmux-vim
backup_dir=$HOME/config_backup

set -e # terminate script on error

function copy_file_if_exist {
  if [[ -f $1 ]] ; then # if file exists
    if [[ -L $1 ]] ; then # if a symlink
      cp -P "$1" "$2"
    else
      cp "$1" "$2"
    fi
  fi
}

function copy_dir_if_exist {
  if [[ -d $1 ]] ; then # if dir exists
    if [[ -L $1 ]] ; then # if a symlink
      cp -P "$1" "$2"
    else
      cp -R "$1" "$2"
    fi
  fi
}

function remove_file_if_exist {
  if [[ -f $1 ]] ; then # if file exists
    rm -f "$1"
  fi
}

function remove_dir_if_exist {
  if [[ -d $1 ]] ; then # if file exists
    if [[ -L $1 ]] ; then # if a symlink
      rm -f "$1"
    else
      rm -r -f "$1"
    fi
  fi  
}

function backup_old_config {
  # check if backup dir does not exist yet -> if not -> backup files
  if [[ ! -d $backup_dir ]] ; then
    echo -e "old config stored in $backup_dir\n"
    mkdir "$backup_dir"

    copy_file_if_exist "$HOME/.bashrc" "$backup_dir/"
    copy_dir_if_exist "$HOME/.tmux/" "$backup_dir/"
    copy_file_if_exist "$HOME/.tmux.conf.local" "$backup_dir/"
    copy_dir_if_exist "$HOME/.vim/" "$backup_dir/"
    copy_file_if_exist "$HOME/.vimrc" "$backup_dir/"
    copy_file_if_exist "$HOME/.tmux.conf" "$backup_dir/"
  fi
}

function remove_old_config {
  remove_file_if_exist "$HOME/.bashrc"
  remove_dir_if_exist "$HOME/.tmux"
  remove_file_if_exist "$HOME/.tmux.conf.local"
  remove_dir_if_exist "$HOME/.vim"
  remove_file_if_exist "$HOME/.vimrc"
  remove_file_if_exist "$HOME/.tmux.conf"
}


function install_new_config {
  # install vundle from git - vim package manager
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  cp "$src/.bashrc" "$HOME/"
  cp -r "$src/.tmux/" "$HOME/"
  cp "$src/.tmux.conf.local" "$HOME/"
  cp -r "$src/.vim/" "$HOME/"
  cp "$src/.vimrc" "$HOME/"
  ln -s -f .tmux/.tmux.conf "$HOME/.tmux.conf"

  # make vim install plugins
  vim +PluginInstall +qall
}

function install {
  echo -e "\ninstalling config files to $HOME...\n"

  backup_old_config

  remove_old_config

  install_new_config

  echo -e "\ndone!\n"
}

case "$1" in
  "remove")
    echo -e "\nremoving config..."
    remove_old_config
    echo -e "\ndone!\n"
    ;;
  *)
    install
    ;;
esac
