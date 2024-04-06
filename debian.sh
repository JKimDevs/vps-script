#!/bin/bash

# Exit on any error
set -e

# SSH and Debian VPS Setup
echo "Starting SSH and Debian VPS Setup..."
rm -f DebianVPS-Installer
wget -q 'https://raw.githubusercontent.com/Bonveio/BonvScripts/master/DebianVPS-Installer'
chmod +x DebianVPS-Installer
./DebianVPS-Installer
echo "SSH and Debian VPS Setup complete."
rm -f DebianVPS-Installer # Cleanup

# dnstt Setup
echo "Starting dnstt Setup..."
rm -rf install
apt update
wget https://github.com/khaledagn/SlowDNS/raw/main/install
chmod 777 install
./install --start
echo "dnstt Setup complete."
rm -f install # Cleanup

echo "All installations have been completed successfully."
