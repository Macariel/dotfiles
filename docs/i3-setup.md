# Initial Setup
## Install Xorg
pacman -S xorg-server xorg-xinit xorg-xrandr

## Install ly DM
yay -S ly-git
systemctl enable ly.service

## Install i3
pacman -S i3-gaps i3lock i3status dmenu

# Font problems
Don't forget to install fonts
pacman -S noto-fonts ttf-dejavu ttf-inconsolata
etc.

If the fonts are displayed correctly, but some icons/glyphs are missing you need to add:
pacman -S xorg-xfd

# HiDPI problems
`xrandr --dpi` 120 for the monitor. Needs to be configured in .Xresource as well
polybar needs the dpi configured separately

# Sound
pacman -S alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth

Unmute audio:
`alsamixer` and press M for Speaker

# Network
pacman -S networkmanager networkmanager-openvpn nm-connection-editor
