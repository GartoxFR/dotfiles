#! /usr/bin/env bash

cd $(dirname -- $0)
mkdir -p $HOME/.config/

# Dotfiles absolute path
DP=$(pwd)

ln -sf $DP/nvim $HOME/.config 
ln -sf $DP/i3 $HOME/.config 
ln -sf $DP/picom $HOME/.config 
ln -sf $DP/polybar $HOME/.config 
ln -sf $DP/rofi $HOME/.config 
ln -sf $DP/spotifyd $HOME/.config 
ln -sf $DP/spotify-tui $HOME/.config 
ln -sf $DP/alacritty.yml $HOME/.config 

ln -sf $DP/kmonad $HOME/.config 

ln -sf $DP/tmux/.tmux.conf $HOME 
ln -sf $DP/tmux/.tmux.conf.local $HOME 

ln -sf $DP/.zshrc $HOME
ln -sf $DP/.Xmodmap $HOME

ln -sf $DP/fish/config.fish $HOME/.config/fish/config.fish
ln -sf $DP/starship.toml $HOME/.config/starship.toml

