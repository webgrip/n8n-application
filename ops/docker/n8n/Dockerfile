FROM docker.n8n.io/n8nio/n8n:1.81.4 AS base

# Switch to root to install dependencies
USER root

RUN apk add --no-cache jq

COPY ./src/workflows /home/node/.n8n/workflows
COPY ./src/credentials /home/node/.n8n/credentials
COPY ./ops/docker/n8n/scripts /home/node/.n8n/scripts

RUN chown -R node:node /home/node/.n8n

USER node

RUN chmod +x /home/node/.n8n/scripts/import-credentials.sh
RUN chmod +x /home/node/.n8n/scripts/import-workflows.sh
RUN chmod +x /home/node/.n8n/scripts/docker-entrypoint.sh

# Final production stage
FROM base AS production
USER node
ENTRYPOINT ["/home/node/.n8n/scripts/docker-entrypoint.sh"]
