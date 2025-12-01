#/bin/bash

printf "n\n\n\n+1M\nef02\nn\n\n\n\n\nw\ny\n" | gdisk /dev/sda

mkfs.ext4 /dev/sda2 && mount dev/sda2 /mnt

sed -i 's/^ParallelDownloads = 5/ParallelDownloads = 100/' /etc/pacman.conf

pacstrap /mnt base linux linux-firmware grub

genfstab -U /mnt > /mnt/etc/fstab; arch-chroot /mnt bash -c 'grub-install --target=i386-pc /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg'
