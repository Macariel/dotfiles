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
git clone https://github.com/macariel/dotfiles # creating the symlinks need to be done manually for now
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

## Fix lspci freeze
```bash
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
```

## Fix reboot freeze
`acpi=off` makes it unable to boot  
Temporary fix: Pressing the shutdown button works

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

## Install xorg
```bash
pacman -S xorg-server xorg-xinit
```

## Install display manager (lightdm)
```bash
pacman -S lightdm ligthdm-webkit2-greeter
```
Set the greeter
```bash
[Seat:*]
...
greeter-session=lightdm-yourgreeter-greeter
```
Enable the service
```
systemctl enable lightdm.service
```

## Disable discrete GPU on boot

## Install NVIDIA driver
