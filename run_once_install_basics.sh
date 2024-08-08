#!/bin/bash - 
# Packages
sudo pacman --needed -Syu git gvim python python-pip docker docker-compose jq base-devel networkmanager-openvpn bluez bluez-utils acpica archlinux-keyring unzip man rsync bind

# Shell
sudo pacman --needed -Syu zsh tmux thefuck htop ripgrep tree z fzf tig exa
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh pawelka

# Fonts and icons
sudo pacman --needed -Syu \
  ttf-roboto-mono `# System` \
  ttf-hack powerline-fonts `# Terminal` \
  papirus-icon-theme 


# Install yay
if [[ ! $(command -v yay) ]]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay
fi

# Work
yay --needed -Syu pnpm terraform terragrunt npm nodejs maven gradle jdk-openjdk jdk17-openjdk jdk8-openjdk

# Programs
yay --needed -S jetbrains-toolbox visual-studio-code-bin firefox google-chrome ferdium-bin guake 1password google-cloud-cli  
