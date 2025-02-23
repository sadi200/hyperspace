#!/bin/bash

Telegram Bot Config

TELEGRAM_BOT_TOKEN="5166999201:AAE7gESJwomwSMlVspWBpJ7Y7wflUiB5UVI" TELEGRAM_CHAT_ID="903018274"

Function to send Telegram notifications

send_telegram_message() { local message="$1" curl -s -X POST "https://api.telegram.org/bot${5166999201:AAE7gESJwomwSMlVspWBpJ7Y7wflUiB5UVI}/sendMessage" -d chat_id="${903018274}" -d text="${message}" }

Infinite loop to keep retrying the script if any part fails

while true; do printf "\n" cat <<EOF

██████  ███████ █       █     █ ██████  ███████ █       █ ██████  █

EOF

printf "\n\n"

# EP Banner
GREEN="\033[0;32m"
RESET="\033[0m"
printf "${GREEN}"
printf "🚀 THIS SCRIPT IS PROUDLY CREATED BY **EP**! 🚀\n"
printf "Stay connected for updates:\n"
printf "   • Telegram: https://t.me/Earnpoint10\n"
printf "   • X (formerly Twitter): https://x.com/earnpoint10\n"
printf "${RESET}"

# Step 1: Install HyperSpace CLI
echo "🚀 Installing HyperSpace CLI..."

while true; do
    curl -s https://download.hyper.space/api/install | bash | tee /root/hyperspace_install.log

    if ! grep -q "Failed to parse version from release data." /root/hyperspace_install.log; then
        echo "✅ HyperSpace CLI installed successfully!"
        send_telegram_message "✅ HyperSpace CLI installed successfully!"
        break
    else
        echo "❌ Installation failed. Retrying in 10 seconds..."
        send_telegram_message "❌ HyperSpace CLI installation failed. Retrying..."
        sleep 5
    fi
done

# Step 2: Add aios-cli to PATH and persist it
echo "🔄 Adding aios-cli path to .bashrc..."
echo 'export PATH=$PATH:$HOME/.aios' >> ~/.bashrc
export PATH=$PATH:$HOME/.aios
source ~/.bashrc

# Step 3: Start the Hyperspace node in a screen session
echo "🚀 Starting the Hyperspace node in the background..."
screen -S hyperspace -d -m bash -c "$HOME/.aios/aios-cli start"
send_telegram_message "🚀 Hyperspace node started in the background."

# Step 4: Wait for node startup
echo "⏳ Waiting for the Hyperspace node to start..."
sleep 10

# Step 5: Check if aios-cli is available
echo "🔍 Checking if aios-cli is installed..."
if ! command -v aios-cli &> /dev/null; then
    echo "❌ aios-cli not found. Retrying..."
    send_telegram_message "❌ aios-cli not found. Retrying..."
    continue
fi

# Step 6: Check node status
echo "🔍 Checking node status..."
aios-cli status

# Step 7: Download the required model
echo "🔄 Downloading the required model..."

while true; do
    aios-cli models add hf:TheBloke/Mistral-7B-Instruct-v0.1-GGUF:mistral-7b-instruct-v0.1.Q4_K_S.gguf | tee /root/model_download.log

    if grep -q "Download complete" /root/model_download.log; then
        echo "✅ Model downloaded successfully!"
        send_telegram_message "✅ Model downloaded successfully!"
        break
    else
        echo "❌ Model download failed. Retrying in 10 seconds..."
        send_telegram_message "❌ Model download failed. Retrying..."
        sleep 5
    fi
done

# Step 8: Ask for private key securely
echo "🔑 Enter your private key:"
read -p "Private Key: " private_key
echo $private_key > /root/my.pem
echo "✅ Private key saved to /root/my.pem"
send_telegram_message "🔑 Private key saved."

# Step 9: Import private key
echo "🔑 Importing your private key..."
aios-cli hive import-keys /root/my.pem
send_telegram_message "✅ Private key imported into Hive."

# Step 10: Login to Hive
echo "🔐 Logging into Hive..."
aios-cli hive login

# Step 11: Connect to Hive
echo "🌐 Connecting to Hive..."
aios-cli hive connect
send_telegram_message "🌐 Connected to Hive."

# Step 12: Display system info
echo "🖥️ Fetching system information..."
aios-cli system-info

# Step 13: Set Hive Tier
echo "🏆 Setting your Hive tier to 3..."
aios-cli hive select-tier 3
send_telegram_message "🏆 Hive tier set to 3."

# Step 14: Check Hive points in a loop every 10 seconds
echo "📊 Checking your Hive points every 10 seconds..."
echo "✅ HyperSpace Node setup complete!"
send_telegram_message "✅ HyperSpace Node setup complete and running!"
echo "ℹ️ Use 'CTRL + A + D' to detach the screen and 'screen -r epspace' to reattach."

while true; do
    echo "ℹ️ Press 'CTRL + A + D' to detach the screen, 'screen -r epspace' to reattach."
    aios-cli hive points
    sleep 10
done

done
