#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/initial-setup-ubuntu.sh

# Prevent annoying needs restart popup 
sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

# Update & Upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install common packages
sudo apt install openssh-server git speedtest-cli fail2ban unattended-upgrades glances -y
sudo snap install bashtop

# Update again
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Disable root login
sudo passwd -l root

# Disable password login over ssh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]yes/c\PasswordAuthentication no" /etc/ssh/sshd_config
sudo service sshd restart

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
sudo systemctl restart fail2ban

# Update one more time
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Exit script
echo "Script completed!"
