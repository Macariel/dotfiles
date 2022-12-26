# Installation guide for Dell XPS 15 and Arch
Adjusted from this [gist](https://gist.github.com/heppu/6e58b7a174803bc4c43da99642b6094b)
, the [arch linux documentation](https://wiki.archlinux.org/index.php/Installation_guide)
and the XPS 15 specific [site](https://wiki.archlinux.org/index.php/Dell_XPS_15_7590)
Additional: [guide](https://github.com/Geigerkind/i3-wm-arch-linux-setup)

## Preparition
### BIOS settings (XPS 15 7590)
* Under 'System Configuration', change the SATA Mode from the default "RAID" to "AHCI". This will allow Linux to detect the NVME SSD.
* Under 'Secure Boot', disable secure boot to allow Linux to boot.
* Under 'POST Behaviour', change "Fastboot" to "Thorough". This prevents intermittent boot failures.
### Create bootable USB
```bash
dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync
```

### Set resolution to something managable
In the arch menu from the USB press `<TAB>` (or `e`) in on the boot arch option and add
`video=1920x1080` at the end

### Boot from USB and set prepare system
```bash
loadkeys de-latin1
timedatectl set-ntp true
```

### Connect to wifi
```bash
wifi-menu
```

## Setup
### Disk partitioning and encryption
#### Create Partitions
See [here](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS) for more information   

We will create 2 partitions, one for boot partition and one for LUKS encrypted partition
nvme0n1p1=/boot
nvme0n1p2=encrypted LVM with root and swap

```bash
gdisk /dev/nvme0n1
```

```
GPT fdisk (gdisk) version 1.0.1

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.

Command (? for help): o
This option deletes all partitions and creates a new protective MBR.
Proceed? (Y/N): Y

Command (? for help): n
Partition number (1-128, default 1): 
First sector (34-242187466, default = 2048) or {+-}size{KMGTP}: 
Last sector (2048-242187466, default = 242187466) or {+-}size{KMGTP}: +512M
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): EF00
Changed type of partition to 'EFI System'

Command (? for help): n
Partition number (2-128, default 2): 
First sector (34-242187466, default = 1050624) or {+-}size{KMGTP}: 
Last sector (1050624-242187466, default = 242187466) or {+-}size{KMGTP}: 
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): 
Changed type of partition to 'Linux filesystem'

Command (? for help): p
Disk /dev/nvme0n1: 242187500 sectors, 115.5 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 9FB9AC2C-8F29-41AE-8D61-21EA9E0B4C2A
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 242187466
Partitions will be aligned on 2048-sector boundaries
Total free space is 2014 sectors (1007.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         1050623   512.0 MiB   EF00  EFI System
   2         1050624       242187466   115.0 GiB   8300  Linux filesystem

Command (? for help): w
```

#### Format, encrypt and mount partitions

I will create only swap and root partitions, but here you can create home, var and other partitions if you wish.

```bash
mkfs.vfat -F32 /dev/nvme0n1p1 # Boot partition

cryptsetup -v luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 cryptlvm 

pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -L 4G vg0 -n swap # Create 
lvcreate -l +100%FREE vg0 -n root

mkfs.ext4 /dev/mapper/vg0-root
mkswap /dev/mapper/vg0-swap

mount /dev/mapper/vg0-root /mnt
swapon /dev/mapper/vg0-swap

mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
```

### Install base system and packages

```bash
pacstrap /mnt base base-devel linux linux-firmware dialog wpa_supplicant networkmanager zsh gvim git z lvm2
```

### Generate fstab

```bash
genfstab -pU /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
# 
# /etc/fstab: static file system information
#
# <file system>	<dir>	<type>	<options>	<dump>	<pass>
# /dev/mapper/vg0-root
UUID=44bc2285-0443-44d6-8208-e914638ee1b1	/         	ext4      	rw,noatime,data=ordered	0 1

# /dev/nvme0n1p1
UUID=AEF3-11A1      	/boot     	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro	0 2

# /dev/mapper/vg0-swap
UUID=708a05f7-633c-4f0f-a16b-3abce7def965	none      	swap      	defaults  	0 0
```

If you have SSD change relatime on all non-boot partitions to noatime.

### chroot into new system and prepare it

```bash
arch-chroot /mnt

ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo <your-hostname> > /etc/hostname

passwd
chsh -s /bin/zsh
```

### Set locales
CA for english language but sane numbers

Uncomment en_CA.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen
```bash
echo LANG=en_CA.UTF-8 > /etc/locale.conf
locale-gen
```

### Install neo2 keyboard layout
https://wiki.neo-layout.org/wiki/Neo%20unter%20Linux%20einrichten/Konsole
```bash
mkdir /usr/share/kbd/keymaps/i386/neo
cd /usr/share/kbd/keymaps/i386/neo
curl https://raw.githubusercontent.com/neo-layout/neo-layout/master/linux/console/neo.map -o neo.map
loadkeys neo
echo KEYMAP=neo > /etc/vconsole.conf
```

### mkinitcpio
#### For the missing packages
https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d

```bash
bootctl --path=/boot install
```

Edit /etc/mkinitcpio.conf
```
MODULES=(ext4)
.
.
.
HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt sd-lvm2 filesystems fsck)
```

### Configure bootloader (systemd-boot)
Create /boot/loader/entries/arch.conf

Download microcode updates:
`pacman -S intel-ucode`

```
title	Arch Linux
linux	/vmlinuz-linux
initrd  /intel-ucode.img
initrd	/initramfs-linux.img
options luks.name=<UUID-OF-ENCRYPTED-PART>=cryptlvm luks.options=discard root=/dev/mapper/vg0-root resume=/dev/mapper/vg0-swap rw quiet video=1920x1080
```
luks.options are necessary for TRIM  
The UUID can be obtained by
```
blkid /dev/nvme0n1p2 > /boot/loader/entries/arch.conf
```

Edit /boot/loader/loader.conf

```
timeout 0
default arch
editor 0
```

### Finish installation and boot to new system

```bash
mkinitcpio -p linux
exit
umount -R /mnt
reboot
```
