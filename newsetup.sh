#!/bin/bash

# Install all updates
sudo apt-get update
sudo apt-get upgrade -y

# Automatically remove outdated programs
sudo apt-get autoremove -y

# Attempt dist-upgrade
sudo apt-get dist-upgrade -y

# Install specified programs
sudo apt-get install glances neofetch docker.io speedtest-cli -y

# Install Bashtop using Snap
sudo snap install bashtop

# Set timezone to Chicago
sudo timedatectl set-timezone America/Chicago

# Prompt user to add a new user and password
read -p "Enter new user name: " username
sudo adduser $username

# Prompt user to upload an SSH key
read -p "Enter the path to the SSH key file: " ssh_key_path
sudo mkdir -p /home/$username/.ssh
sudo cat $ssh_key_path >> /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh

# Set up ufw to allow all outgoing traffic, deny all incoming traffic, enable itself
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
echo "y" | sudo ufw enable

# Add current user to Docker user group
sudo usermod -aG docker $USER

# Disable root SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# Disable SSH password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Add custom message to be displayed to user on login
echo "Welcome to the server! Please contact the administrator if you have any questions." | sudo tee -a /etc/motd

# Restart SSH service to apply changes
sudo service ssh restart
