#! /usr/bin/env bash
sudo pacman -Syu --needed git zsh

#Ohmyzsh installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sudo pacman -Syu --needed xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings i3-gaps i3lock polybar picom rofi

sudo pacman -Syu --needed fzf ripgrep bat bat-extras tmux neovim firefox

# Install yay
pushd /tmp
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
popd

yay -Syu nerd-fonts-jetbrains-mono 

./create_links.sh
