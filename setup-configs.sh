#!/bin/bash
src_dir="$( cd "$(dirname "$0")"; pwd -P )"

ln_for() {
    [[ ! -L .$1 ]] && ln -s $src_dir/$1 .$1
}

# Symlinks for configs
cd ~
ln_for zshrc
ln_for vimrc
ln_for tmux.conf
ln_for oh-my-zsh-custom
ln_for gitconfig
ln_for xbindkeysrc

# setup guake
guake --restore-preferences="$src_dir/guake"
