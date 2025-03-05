# Use your desired base n8n image.
# If you have a private registry, keep that URL; otherwise use Docker Hub's official:
FROM docker.n8n.io/n8nio/n8n:1.81.4

# Become root temporarily to install packages and adjust files
USER root

# Example: Install any needed utilities
RUN apk add --no-cache jq

# Copy your workflows and credentials into /home/node/.n8n
COPY ./src/workflows /workflows
COPY ./src/credentials /credentials

# Adjust ownership so the `node` user can read/write
RUN chown -R node:node /home/node/.n8n

# Copy entrypoint scripts into a directory that won't get overwritten by volume mounts
COPY ./ops/docker/n8n/scripts /docker-scripts

# Make scripts executable & adjust permissions
RUN chmod +x /docker-scripts/*.sh && chown -R node:node /docker-scripts

# Switch back to the non-root user
USER node

# Finally, set the container ENTRYPOINT to your script
ENTRYPOINT ["/docker-scripts/docker-entrypoint.sh"]
