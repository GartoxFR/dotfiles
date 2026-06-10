#! /usr/bin/env bash

cd $(dirname -- $0)
mkdir -p $HOME/.config/

# Dotfiles absolute path
DP=$(pwd)

ln -sf $DP/rofi $HOME/.config 
ln -sf $DP/hypr $HOME/.config 
ln -sf $DP/waybar $HOME/.config 


ln -sf $DP/tmux/.tmux.conf $HOME 
ln -sf $DP/tmux/.tmux.conf.local $HOME 
