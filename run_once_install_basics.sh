#!/bin/bash - 
# Packages
sudo pacman --needed -Syu git tar curl gvim python python-pip docker docker-compose jq base-devel networkmanager-openvpn bluez bluez-utils acpica archlinux-keyring unzip man rsync inetutils bind

# Shell
sudo pacman --needed -Syu zsh tmux thefuck htop ripgrep tree z fzf tig exa fd pyenv
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh pawelka

# Setup locale
echo "Setting up locale"
sudo localectl set-x11-keymap de pc105 neo

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
yay --needed -Syu pnpm terraform terragrunt npm nodejs maven gradle jdk-openjdk jdk21-openjdk

# Programs
yay --needed -S jetbrains-toolbox visual-studio-code-bin firefox google-chrome ferdium-bin guake 1password 1password-cli claude-code

# GCloud
if ! command -v gcloud &> /dev/null; then
	curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
	tar -xf google-cloud-cli-linux-x86_64.tar.gz
	rm google-cloud-cli-linux-x86_64.tar.gz
	sudo mv google-cloud-sdk /opt/google-cloud-sdk
	/opt/google-cloud-sdk/install.sh
	/opt/google-cloud-sdk/bin/gcloud init
fi

