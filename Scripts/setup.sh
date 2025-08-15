#!/bin/bash
set -e  # Exit on any error

#VARS
PCAP_PW="infected_20250122"
PCAP_OUT="dark_kittens.pcap"
LAB_DIR="/home/ubuntu/lab"
PCAP_URL="https://www.malware-traffic-analysis.net/2025/01/22/2025-01-22-traffic-analysis-exercise.pcap.zip"
RDP_USER="ubuntu"
RDP_PASS='N0ts0secure1'

sleep 60  # Wait for network to be fully up

exec > >(tee /var/log/user-data.log) 2>&1 # Log everything

echo "Starting user-data script execution..."
apt-get update -y
apt-get install -y wget unzip
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install snort wireshark tshark #Interactive mode seems to hang, so use non-interactive mode

##Experimenting with XRDP, likely don't need it just want to see if it works
apt-get install -y xfce4 xfce4-goodies xrdp #Allow remote desktop access
systemctl enable xrdp
systemctl start xrdp
echo "startxfce4" > /home/ubuntu/.xsession # Set default desktop environment for XRDP
sudo chown ubuntu:ubuntu /home/ubuntu/.xsession # Ensure the user owns the .xsession file

echo "[*] Setting password for user $RDP_USER..."
echo "$RDP_USER:$RDP_PASS" | sudo chpasswd

# Download PCAP
mkdir -p "$LAB_DIR" # Create lab directory if it doesn't exist
cd "$LAB_DIR" # Change to lab directory
wget "$PCAP_URL"  # Download the PCAP file
sudo chown ubuntu:ubuntu -R $LAB_DIR # Ensure the user owns the zip file

# Prepare Snort with basic rule set pre-added, maybe change to have learner modify it 
echo "include \$RULE_PATH/local.rules" >> /etc/snort/snort.conf
