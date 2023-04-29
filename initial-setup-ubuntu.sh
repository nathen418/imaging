#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/initial-setup-ubuntu.sh

# Update & Upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install common packages
sudo apt install openssh-server git speedtest-cli fail2ban  glances -y
sudo snap install bashtop

# Disable root login
sudo passwd -l root

# Disable password login over ssh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]yes/c\PasswordAuthentication no" /etc/ssh/sshd_config

# Extend ubuntu default fs to fill the disk
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv

# Change the default time zone
sudo timedatectl set-timezone America/Chicago

# Set basic firewall rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
echo "y" | sudo ufw enable

# Make backup and configure fail2ban
sudo cp /etc/fail2ban/fail2ban.{conf,local}
sudo cp /etc/fail2ban/jail.{conf,local}
sudo sed -i "/^[^#]*backend = auto/c\backend = systemd" /etc/fail2ban/jail.local

# Exit script
echo "Script completed!"
