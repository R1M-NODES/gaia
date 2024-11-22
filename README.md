<b> Install Gaia </b>

```
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/gaia/master/install.sh)
```

Port
```
nano "$HOME/gaianet/config.json"
```

Install 2
```
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/gaia/master/install2.sh)
```


<b> Install Script </b>

```
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/gaia/master/script.sh)
```

Screen
```
screen -S faker_session
python3 ~/random_chat_with_faker.py
```

Logs
```
journalctl -u gaianet.service -f
```

Restart
```
sudo systemctl restart gaianet.service && journalctl -u gaianet.service -f
```

Delete
```
sudo systemctl stop gaianet.service && sudo systemctl disable gaianet.service && sudo rm -f /etc/systemd/system/gaianet.service && sudo systemctl daemon-reload && sudo rm -rf /root/gaianet
```

https://www.gaianet.ai/gaia-domain-name?referralCode=RwxQes
