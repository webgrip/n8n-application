# Makefile

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

enter:
	docker-compose exec n8n /bin/sh

## Import all JSON workflows into n8n
import:
	docker-compose exec n8n n8n import:workflow --separate --input=/n8n/workflows
