#!/bin/sh
set -e

echo "Running import-credentials.sh..."

# Ensure the credentials directory exists
mkdir -p /credentials

# Ensure correct filenames are used
if [ -f "/credentials/openapi.json" ]; then
    echo "Updating openapi.json..."
    jq --arg apiKey "$OPENAI_API_KEY" '.data = $apiKey' /credentials/openapi.json > tmp && mv tmp /credentials/openapi.json
else
    echo "Warning: openapi.json not found, skipping..."
fi

if [ -f "/credentials/telegram.json" ]; then
    echo "Updating telegram.json..."
    jq --arg apiKey "$TELEGRAM_API_KEY" '.data = $apiKey' /credentials/telegram.json > tmp && mv tmp /credentials/telegram.json
else
    echo "Warning: telegram.json not found, skipping..."
fi

# Import credentials into n8n
n8n import:credentials --separate --input=/credentials
