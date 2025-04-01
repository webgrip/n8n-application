#!/bin/sh
set -e

# Define script directory
SCRIPT_DIR="/docker-scripts"

# Run credential import script
if [ -f "$SCRIPT_DIR/import-credentials.sh" ]; then
    echo "Running import-credentials.sh..."
    sh "$SCRIPT_DIR/import-credentials.sh"
else
    echo "import-credentials.sh not found, skipping..."
fi

# Run workflow import script
if [ -f "$SCRIPT_DIR/import-workflows.sh" ]; then
    echo "Running import-workflows.sh..."
    sh "$SCRIPT_DIR/import-workflows.sh"
else
    echo "import-workflows.sh not found, skipping..."
fi

# Handle custom certificates if present
if [ -d /opt/custom-certificates ]; then
    echo "Trusting custom certificates from /opt/custom-certificates."
    export NODE_OPTIONS="--use-openssl-ca $NODE_OPTIONS"
    export SSL_CERT_DIR="/opt/custom-certificates"

    # Check if `c_rehash` exists before running
    if command -v c_rehash >/dev/null 2>&1; then
        c_rehash /opt/custom-certificates
    else
        echo "Warning: c_rehash not found. Skipping certificate rehashing."
    fi
fi

if [ -f "$SCRIPT_DIR/install-community-nodes.sh" ]; then
    echo "Running install-community-nodes.sh..."
    sh "$SCRIPT_DIR/install-community-nodes.sh"
else
    echo "install-community-nodes.sh not found, skipping..."
fi

# Start n8n with or without additional arguments
if [ "$#" -gt 0 ]; then
    echo "Starting n8n with arguments: $@"
    exec n8n "$@"
else
    echo "Starting n8n..."
    exec n8n
fi
