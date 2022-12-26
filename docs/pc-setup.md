# Setup of the newly installed arch linux
### Setup internet (WLAN)
```bash
# https://docs.ubuntu.com/core/en/stacks/network/network-manager/docs/configure-wifi-connections
# (d=device, r=radio)
nmcli d
nmcli r wifi on # make sure wifi is enabled
nmcli d wifi list # get SSID of your wifi 
nmcli d wifi connect <SSID> password <password>
```

### ZSH Problems with ~
zsh is not using /etc/inputsrc, therefore some keys are not mapped correctly  
This can be solved by installing oh-my-zsh and the dotfiles
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir Config
cd Config
git clone https://github.com/macariel/dotfiles
```

### Setup non-root user
```bash
# https://wiki.archlinux.org/index.php/Users_and_groups
useradd -m -G wheel -s /usr/bin/zsh <username>
passwd <username>
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
usermod -aG network,video,audio,storage,users <username>
```

### Enable weekly TRIM for SSD
```
# https://wiki.archlinux.org/index.php/Solid_state_drive#Periodic_TRIM
pacman -S util-linux
systemctl enable fstrim.timer
```

# Graphics
## Install drivers
https://wiki.archlinux.org/index.php/Xorg#Driver_installation
```bash
lspci | grep -e VGA -e 3D
pacman -Ss xf86-video
```

```bash
pacman -S nvidia
```

# System setup
## Install yay AUR package manager
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## Setup vim
Go to https://github.com/Shougo/dein.vim and use the installer.sh to install dein  
`sh installer.sh ~/.vim/bundles`

## Setup zsh
Go to https://ohmyz.sh/#install and install oh-my-zsh in `~/.config/dotfiles/`

## Setup ssh-agent
https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login

Create a systemd user service, by putting the following to ~/.config/systemd/user/ssh-agent.service:
```
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Setup shell to have an environment variable for the socket (.bash_profile, .zshrc, ...):

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

Enable the service, so it'll be started automatically on login, and start it:

systemctl --user enable ssh-agent
systemctl --user start ssh-agent

