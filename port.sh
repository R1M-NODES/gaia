#!/bin/bash

# Path to the configuration file (update this path if necessary)
CONFIG_FILE="$HOME/gaianet/config.json"  # Or provide an absolute path, e.g., "/home/user/gaianet/config.json"

# Old and new ports
OLD_PORT=8080
NEW_PORT=8200

# Check if jq is installed
if ! command -v jq &>/dev/null; then
  echo "jq is not installed. Installing jq..."
  if [[ -f /etc/debian_version ]]; then
    sudo apt-get update && sudo apt-get install -y jq
  elif [[ -f /etc/redhat-release ]]; then
    sudo yum install -y jq
  else
    echo "Unknown system. Please install jq manually."
    exit 1
  fi
fi

# Check if the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Configuration file $CONFIG_FILE not found!"
  exit 1
fi

# Change the port in the configuration file
jq ".port = $NEW_PORT" "$CONFIG_FILE" > temp_config.json && mv temp_config.json "$CONFIG_FILE"

if [[ $? -eq 0 ]]; then
  echo "Port successfully changed from $OLD_PORT to $NEW_PORT in the $CONFIG_FILE file."
else
  echo "Error while changing the port."
  exit 1
fi

# Restart the gaianet service and display its logs
echo "Restarting the gaianet service..."
sudo systemctl restart gaianet.service

if [[ $? -eq 0 ]]; then
  echo "Gaianet service successfully restarted. Displaying logs:"
  sudo journalctl -u gaianet.service -f
else
  echo "Error while restarting the gaianet service."
  exit 1
fi
