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

## Encrypt values.yaml -> values.sops.yaml in the specified directory
encrypt-secrets:
ifndef SECRETS_DIR
	$(error SECRETS_DIR is not set. Usage: mamkke encrypt-secrets SECRETS_DIR=./path/to/secrets)
endif
	sops --encrypt --age $$(cat age.pubkey) $(SECRETS_DIR)/values.dec.yaml > $(SECRETS_DIR)/values.sops.yaml
	@echo "Encrypted: $(SECRETS_DIR)/values.dec.yaml -> $(SECRETS_DIR)/values.sops.yaml"

decrypt-secrets:
ifndef SECRETS_DIR
	$(error SECRETS_DIR is not set. Usage: make decrypt-secrets SECRETS_DIR=./path/to/secrets)
endif
	@echo "Decrypting secrets..."
	@SOPS_AGE_KEY="$$(cat ./age.agekey)" \
		sops --decrypt $(SECRETS_DIR)/values.sops.yaml > $(SECRETS_DIR)/values.dec.yaml
