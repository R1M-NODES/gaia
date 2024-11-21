#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)
printLogo

sudo apt update -y && sudo apt-get update -y

curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash
source ~/.bashrc
gaianet init --config https://raw.githubusercontent.com/R1M-NODES/gaia/master/config.json
gaianet start
gaianet info

sudo bash -c "cat > /etc/systemd/system/gaianet.service" <<EOL
[Unit]
Description=Gaianet Node Service
After=network.target

[Service]
Type=forking
RemainAfterExit=true
ExecStart=/root/gaianet/bin/gaianet start
ExecStop=/root/gaianet/bin/gaianet stop
ExecStopPost=/bin/sleep 20
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl restart gaianet.service
sudo systemctl enable gaianet.service
sudo systemctl status gaianet.service
