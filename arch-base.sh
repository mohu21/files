#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.local arch" >> /etc/hosts
echo root:pw | chpasswd

pacman -S grub efibootmgr networkmanager base-devel bash-completion openssh rsync os-prober alacritty firefox nvidia

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable sshd

useradd -m moritz
echo moritz:pw | chpasswd

echo "moritz ALL=(ALL) ALL" >> /etc/sudoers.d/moritz

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
