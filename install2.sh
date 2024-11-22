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
