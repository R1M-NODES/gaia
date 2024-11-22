#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)
printLogo


read -p "Subdomain: " WALLET_ADDRESS

sudo apt update -y && sudo apt upgrade -y

sudo apt install python3-pip -y
sudo apt install nano -y
sudo apt install screen -y

pip install requests
pip install faker

cat > ~/random_chat_with_faker.py <<EOL
import requests
import random
import logging
import time
from faker import Faker
from datetime import datetime

node_url = "https://${WALLET_ADDRESS}.us.gaianet.network/v1/chat/completions"

faker = Faker()

headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
}

logging.basicConfig(filename='chat_log.txt', level=logging.INFO, format='%(asctime)s - %(message)s')

def log_message(node, message):
    logging.info(f"{node}: {message}")

def send_message(node_url, message):
    try:
        response = requests.post(node_url, json=message, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Failed to get response from API: {e}")
        return None

def extract_reply(response):
    if response and 'choices' in response:
        return response['choices'][0]['message']['content']
    return ""

while True:
    random_question = faker.sentence(nb_words=10)
    message = {
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": random_question}
        ]
    }

    question_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    response = send_message(node_url, message)
    reply = extract_reply(response)

    reply_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    log_message("Node replied", f"Q ({question_time}): {random_question} A ({reply_time}): {reply}")

    print(f"Q ({question_time}): {random_question}\nA ({reply_time}): {reply}")

    delay = random.randint(60, 180)
    time.sleep(delay)
EOL

# Инструкция по запуску
echo "Скрипт создан. Запустите сессию screen с командой:
screen -S faker_session
Затем запустите скрипт командой:
python3 ~/random_chat_with_faker.py
Для выхода из screen нажмите CTRL+A, затем D.
Для возвращения в сессию используйте команду:
screen -r faker_session"
