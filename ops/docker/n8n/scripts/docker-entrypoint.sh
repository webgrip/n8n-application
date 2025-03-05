#!/bin/sh
set -e

# Run custom credential setup script
if [ -f "/home/node/.n8n/scripts/import-credentials.sh" ]; then
    echo "Running import-credentials.sh..."
    . /home/node/.n8n/scripts/import-credentials.sh
else
    echo "import-credentials.sh not found, skipping..."
fi

# Run workflow import script
if [ -f "/home/node/.n8n/scripts/import-workflows.sh" ]; then
    echo "Running import-workflows.sh..."
    . /home/node/.n8n/scripts/import-workflows.sh
else
    echo "import-workflows.sh not found, skipping..."
fi

# Handle custom certificates if present
if [ -d /opt/custom-certificates ]; then
  echo "Trusting custom certificates from /opt/custom-certificates."
  export NODE_OPTIONS=--use-openssl-ca $NODE_OPTIONS
  export SSL_CERT_DIR=/opt/custom-certificates
  c_rehash /opt/custom-certificates
fi

if [ "$#" -gt 0 ]; then
  # Got started with arguments
  exec n8n "$@"
else
  # Got started without arguments
  exec n8n
fi
