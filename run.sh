#/bin/bash

device=${1:-"sda"}

if [ ! -f "/dev/${device}" ]; then


	printf "n\n\n\n+1M\nef02\nn\n\n\n\n\nw\ny\n" | gdisk "/dev/${device}"
	
	mkfs.ext4 "/dev/${device}2" && mount "/dev/${device}2" /mnt
	
	#sed -i 's/^ParallelDownloads = 5/ParallelDownloads = 100/' /etc/pacman.conf
	
	pacstrap /mnt base linux linux-firmware grub
	
	genfstab -U /mnt > /mnt/etc/fstab; arch-chroot /mnt bash -c "grub-install --target=i386-pc /dev/${device}; grub-mkconfig -o /boot/grub/grub.cfg"
	
	reboot
fi
echo "device ${device} doesn't exist"
