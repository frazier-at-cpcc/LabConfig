#!/bin/bash

echo "Configuring Serverb..."

# Update and install necessary tools
sudo dnf update -y
sudo dnf install vim openssh-server htop -y

# Enable and start SSH service
sudo systemctl enable sshd
sudo systemctl start sshd

# Configure SSH server
echo "Hardening SSH server..."
sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

# Set static IP configuration
echo "Configuring static IP for serverb..."
sudo nmcli connection modify "Wired connection 1" ipv4.addresses "192.168.122.102/24" ipv4.gateway "192.168.122.1" ipv4.dns "8.8.8.8" ipv4.method manual
sudo nmcli connection up "Wired connection 1"

# Create logs directory
echo "Setting up /data/logs directory..."
sudo mkdir -p /data/logs
sudo chmod 1777 /data/logs

# Create sample files for search tasks
echo "Creating sample files in /var/tmp/lab_files..."
sudo mkdir -p /var/tmp/lab_files
sudo touch /var/tmp/lab_files/{test1,test2,test3}
sudo chown contractor1:contractor /var/tmp/lab_files/test1
sudo chmod 640 /var/tmp/lab_files/test1
sudo truncate -s 100 /var/tmp/lab_files/test2

echo "Serverb setup complete."