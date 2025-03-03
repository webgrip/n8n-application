# Makefile

# List of workflow JSON files to import
AGENT_FILES = \
	__Calendar_Agent.json \
	__Contact_Agent.json \
	__Content_Creator_Agent.json \
	__Email_Agent.json \
	Ultimate_Personal_Assistant.json

.PHONY: start stop logs import

## Start the Docker Compose stack
start:
	docker-compose up -d

## Stop the Docker Compose stack
stop:
	docker-compose down

## View logs of all services (Ctrl+C to exit)
logs:
	docker-compose logs -f

## Import all JSON workflows into n8n
import:
	docker-compose exec n8n n8n import:workflow --separate --input=/home/node/.n8n/workflows
