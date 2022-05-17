#!/bin/bash

# This script is designed to force ubuntu to grab a new ip from your router every time it boots.
# For some vm's imported from esxi to proxmox/qemu networking settings are messed up and this can fix things in the short term.
# Do NOT rely on this script for long term stability.
# Note: Servers usually expect a static ip address, and since this is using dhclient, you must set that static ip on your router
# or you risk getting a new ip on each boot.

# Create rc.local file if it does not already exist
sudo nano /etc/rc.local

# Update rc.local's permissions
sudo chmod 755 /etc/rc.local

# Enable rc.local service on boot and verify it's running properly
sudo systemctl enable rc-local
sudo systemctl restart rc-local
sudo systemctl status rc-local

# update and upgrade just to be safe
sudo apt update
sudo apt upgrade -y

# Reboot to test if changes worked. You should be able to now access your virtual machine on boot from it's ip
sudo reboot
