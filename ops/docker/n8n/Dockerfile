# Use the official n8n image
FROM docker.n8n.io/n8nio/n8n:1.82.1

# Switch to root to install packages and configure files
USER root

# Install utilities (example: jq)
RUN apk add --no-cache jq

# Define fixed directories for scripts, workflows, and credentials
WORKDIR /docker-scripts

# Copy entrypoint scripts and ensure proper permissions
COPY ./ops/docker/n8n/scripts/ .
RUN chmod +x docker-entrypoint.sh && chown -R node:node /docker-scripts

# Copy workflows and credentials into dedicated directories
WORKDIR /data
COPY ./src/workflows /data/workflows
COPY ./src/credentials /data/credentials

# Ensure node user has correct ownership
RUN chown -R node:node /data

# Switch back to node user for security
USER node

# Set entrypoint script
ENTRYPOINT ["/docker-scripts/docker-entrypoint.sh"]
