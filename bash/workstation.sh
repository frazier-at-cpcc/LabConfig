#!/bin/bash

echo "Configuring Workstation..."

# Update and install necessary tools
sudo dnf update -y
sudo dnf install vim openssh-clients -y

# Generate SSH key
echo "Generating SSH key for Workstation..."
ssh-keygen -q -t rsa -N "" -f ~/.ssh/workstation_key

# Add SSH configuration
echo "Configuring SSH access to servera and serverb..."
cat <<EOF >> ~/.ssh/config
Host servera
    HostName 192.168.122.101
    User student
    IdentityFile ~/.ssh/workstation_key

Host serverb
    HostName 192.168.122.102
    User student
    IdentityFile ~/.ssh/workstation_key
EOF

# Create shared directory for the lab
mkdir -p ~/lab_shared

echo "Workstation setup complete. Ensure SSH keys are distributed to servera and serverb after they are configured."