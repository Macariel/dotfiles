#!/bin/bash - 
# Packages
sudo pacman --needed -Syu git python python-pip docker docker-compose jq arandr tmux thefuck htop ripgrep tree z fzf xclip tig exa base-devel powerline-fonts wmctrl xdotools papirus-icon-theme networkmanager-openvpn bluez bluez-utils acpica archlinux-keyring guake

# Install yay
if [[ ! $(command -v yay) ]]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay
fi

# Work
yay --needed -Syu visual-studio-code-bin intellij-idea-ultimate-edition-jre intellij-idea-ultimate-edition google-chrome ferdium-bin pnpm terraform terragrunt npm nodejs maven gradle jdk-openjdk jdk8-openjdk
