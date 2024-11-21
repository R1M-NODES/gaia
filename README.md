<b> Install Gaia </b>

```
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/gaia/master/install.sh)
```

Logs
```
journalctl -u gaianet.service -f
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
