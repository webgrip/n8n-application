FROM n8nio/n8n:1.84.3

USER root

RUN apk add --no-cache jq

WORKDIR /docker-scripts

COPY ./ops/docker/n8n/scripts/ .
RUN chmod +x docker-entrypoint.sh && chown -R node:node /docker-scripts

WORKDIR /data
COPY ./src/workflows /data/workflows
COPY ./src/credentials /data/credentials

RUN chown -R node:node /data

USER node

ENTRYPOINT ["/docker-scripts/docker-entrypoint.sh"]
