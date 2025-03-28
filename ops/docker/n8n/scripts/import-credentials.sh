#!/bin/sh
set -e

echo "Running import-credentials.sh..."

# Ensure the credentials directory exists
mkdir -p /data/data/credentials

# Ensure correct filenames are used
if [ -f "/data/credentials/openapi.json" ]; then
    echo "Updating openapi.json..."
    jq --arg apiKey "$OPENAI_API_KEY" '.data = $apiKey' /data/credentials/openapi.json > tmp && mv tmp /data/credentials/openapi.json
else
    echo "Warning: openapi.json not found, skipping..."
fi

if [ -f "/data/credentials/telegram.json" ]; then
    echo "Updating telegram.json..."
    jq --arg apiKey "$TELEGRAM_API_KEY" '.data = $apiKey' /data/credentials/telegram.json > tmp && mv tmp /data/credentials/telegram.json
else
    echo "Warning: telegram.json not found, skipping..."
fi

# Import credentials into n8n
N8N_ENCRYPTION_KEY=$N8N_ENCRYPTION_KEY n8n import:credentials --separate --input=/data/credentials
