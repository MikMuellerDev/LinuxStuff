#!/bin/bash
echo "Checking efivars"
ls /sys/firmware/efi/efivars
echo "Checking networking"
ip a
echo "ping mik-mueller.de"
ping mik-mueller.de -c 1
timedatectl set-ntp true
echo "start disk formatting"
cfdisk /dev/sda
mkfs.ext4 /dev/sda3
mkfs.vfat /dev/sda1
mkswap /dev/sda2
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
echo "finished disk formatting"
echo "installing system"
pacstrap /mnt base linux linux-firmware vim grub efibootmgr networkmanager plasma sddm
echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab
echo "finished generating fstab"

# Edit files before doing chroot
ln -sf /mnt/usr/share/zoneinfo/Europe/Berlin /mnt/etc/localtime
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /mnt/etc/locale.gen
echo "LANG=en_US.UTF-8" >> /mnt/etc/locale.conf
echo "abc" >> /mnt/etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 abc".localdomain "abc" >> /mnt/etc/hosts
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /mnt/etc/sudoers

# Set Time zone and configure locales
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt locale-gen

# User setup
arch-chroot /mnt useradd -m -G wheel mik
arch-chroot /mnt passwd
arch-chroot /mnt passwd mik

# Grub install
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# services
arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt systemctl enable sddm

echo "Install finished!"