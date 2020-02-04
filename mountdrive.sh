#!/bin/bash
sudo fdisk -l
sudo apt install -yy ntfs-3g
sudo mkdir /media/USBDrive
sudo mount -t ntfs-3g /dev/sdb1 /media/USBDrive
