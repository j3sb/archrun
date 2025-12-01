#/bin/bash

parted /dev/sda --script mklabel gpt mkpart ESP fat32 1MiB 513MiB set 1 esp on mkpart primary ext4 513MiB 100%

mkfs.ext4 /dev/sda2 && mount dev/sda2 /mnt

sed -i 's/^ParallelDownloads = 5/ParallelDownloads = 100/' /etc/pacman.conf

pacstrap /mnt base linux linux-firmware grub

genfstab -U /mnt > /mnt/etc/fstab; arch-chroot /mnt bash -c 'grub-install --target=i386-pc /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg'; reboot
