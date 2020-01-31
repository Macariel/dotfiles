#!/bin/bash
root_dir="$( cd "$(dirname "$0")"; cd ..; pwd -P )"

_ln() {
  ln -nsf $root_dir/configs/$1 $2$1
}

# Symlinks for configs
cd $HOME
_ln zshrc .
_ln vimrc .
_ln tmux.conf .
_ln gitconfig .
_ln Xresource .
_ln oh-my-zsh .
_ln oh-my-zsh-custom .
_ln tmux .
_ln vim .

cd $HOME/.config
_ln polybar
_ln rofi
_ln i3
_ln gtk-3.0
_ln gsimplecal
_ln htop
