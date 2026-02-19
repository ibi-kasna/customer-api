APP_DIR   := app
INFRA_DIR := infra

ENV ?= dev
TF_BACKEND_CONF = env/$(ENV)/backend.conf
TFVARS = env/$(ENV)/terraform.tfvars
DOCKER_IMAGE_NAME ?= hello-world-app

# Set default goal to help
.DEFAULT_GOAL := help

# --- Application Targets ---

app-install: ## Install dependencies
	cd $(APP_DIR) && npm ci

app-lint: ## Run linting
	cd $(APP_DIR) && npm run lint

app-test: ## Run tests
	cd $(APP_DIR) && npm test

app-build: ## Build the application
	cd $(APP_DIR) && npm run build

app-docker-build: ## Build Docker image
	cd $(APP_DIR) && docker build --no-cache -t $(DOCKER_IMAGE_NAME) .

# --- Infrastructure Targets ---

infra-init: ## Initialize Terraform
	cd $(INFRA_DIR) && terraform init -backend-config=$(TF_BACKEND_CONF)

infra-plan: ## Plan Terraform changes
	cd $(INFRA_DIR) && terraform plan -var-file=$(TFVARS)

infra-apply: ## Apply Terraform changes
	cd $(INFRA_DIR) && terraform apply -var-file=$(TFVARS) -auto-approve 

infra-destroy: ## Destroy Terraform changes
	cd $(INFRA_DIR) && terraform destroy -var-file=$(TFVARS) -auto-approve 

help: ## Show all commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: help app-install app-lint app-test app-build app-docker-build infra-init infra-plan infra-apply infra-destroy
