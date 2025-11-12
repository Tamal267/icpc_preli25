#!/bin/bash

set -eu

echo "y" | sudo apt update 

# Uninstall VScode
sudo apt remove --purge code && \
sudo rm -f /etc/apt/sources.list.d/vscode.list /etc/apt/keyrings/packages.microsoft.gpg && \
sudo apt autoremove && sudo apt autoclean && sudo apt update && \
echo "VScode Uninstalled"

# Install VScodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
echo 'deb https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium

echo "VScodium Installed"

# Reset UFW
echo "y" | sudo ufw reset

# Set default policies to ALLOW
sudo ufw default allow incoming
sudo ufw default allow outgoing

# Block specific IPs for AI chatbots
sudo ufw deny out from any to 172.64.155.209
sudo ufw deny out from any to 104.18.32.47
sudo ufw deny out from any to 104.18.26.90
sudo ufw deny out from any to 104.18.27.90
sudo ufw deny out from any to 74.125.200.138
sudo ufw deny out from any to 74.125.200.100
sudo ufw deny out from any to 74.125.200.139
sudo ufw deny out from any to 74.125.200.101
sudo ufw deny out from any to 74.125.200.102
sudo ufw deny out from any to 74.125.200.113
sudo ufw deny out from any to 160.79.104.10

# Enable UFW
sudo ufw enable

echo "Chatbots are blocked"

# Change password
sudo usermod -p '$1$Np8w3vqp$RfW9woGUN.K6yl2cNOYVi0' admin_pc

echo "DONE"
