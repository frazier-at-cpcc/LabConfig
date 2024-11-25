#!/bin/bash

echo "Configuring Servera..."

# Update and install necessary tools
sudo dnf update -y
sudo dnf install vim openssh-server -y

# Enable and start SSH service
sudo systemctl enable sshd
sudo systemctl start sshd

# Configure users and groups
echo "Creating secureops group and users..."
sudo groupadd secureops
sudo useradd -m -G secureops dataadmin
sudo useradd -m -G secureops netadmin
echo "redhat" | sudo passwd --stdin dataadmin
echo "redhat" | sudo passwd --stdin netadmin

# Configure password policies for dataadmin
echo "Configuring password policies for dataadmin..."
sudo chage -m 10 -M 30 -d 0 dataadmin

# Set up directories and permissions
echo "Creating and configuring /data/reports..."
sudo mkdir -p /data/reports
sudo chown dataadmin:secureops /data/reports
sudo chmod 2775 /data/reports

echo "Servera setup complete."