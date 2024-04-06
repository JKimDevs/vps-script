#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Function to perform SSH setup
setup_ssh() {
  echo "Starting SSH setup..."
  rm -f setup.sh
  sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sysctl -w net.ipv6.conf.default.disable_ipv6=1
  apt update && apt install -y bzip2 gzip coreutils screen curl unzip
  if wget https://raw.githubusercontent.com/senowahyu62/scriptvps/main/setup.sh; then
    chmod +x setup.sh
    ./setup.sh
    echo "SSH setup complete."
  else
    echo "Failed to download SSH setup script. Aborting."
    exit 1
  fi
}

# Function to perform dnstt setup
setup_dnstt() {
  echo "Starting dnstt setup..."
  rm -rf install
  apt update
  if wget https://github.com/khaledagn/SlowDNS/raw/main/install; then
    chmod 777 install
    ./install --start
    echo "dnstt setup complete."
  else
    echo "Failed to download dnstt script. Aborting."
    exit 1
  fi
}

# Perform setups
setup_ssh
setup_dnstt

# Cleanup downloaded scripts
echo "Cleaning up downloaded scripts..."
rm -f setup.sh
rm -rf install
echo "Cleanup complete. Script execution finished."
