#!/bin/sh
set -e

echo "Running import-credentials.sh..."

# Ensure the credentials directory exists
mkdir -p /home/node/.n8n/credentials

# Debug: Check what files actually exist before running jq
ls -la /home/node/.n8n/credentials/

# Ensure correct filenames are used
if [ -f "/home/node/.n8n/credentials/openapi.json" ]; then
    echo "Updating openapi.json..."
    jq --arg apiKey "$OPENAI_API_KEY" '.data = $apiKey' /home/node/.n8n/credentials/openapi.json > tmp && mv tmp /home/node/.n8n/credentials/openapi.json
else
    echo "Warning: openapi.json not found, skipping..."
fi

if [ -f "/home/node/.n8n/credentials/telegram.json" ]; then
    echo "Updating telegram.json..."
    jq --arg apiKey "$TELEGRAM_API_KEY" '.data = $apiKey' /home/node/.n8n/credentials/telegram.json > tmp && mv tmp /home/node/.n8n/credentials/telegram.json
else
    echo "Warning: telegram.json not found, skipping..."
fi

# Import credentials into n8n
n8n import:credentials --separate --input=/home/node/.n8n/credentials
