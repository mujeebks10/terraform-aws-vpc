
### `Makefile`
```makefile
.PHONY: help init plan apply destroy clean dev staging prod validate fmt

help:
	@echo "Available commands:"
	@echo "  make dev          - Deploy to dev environment"
	@echo "  make staging      - Deploy to staging environment"
	@echo "  make prod         - Deploy to production environment"
	@echo "  make plan-dev     - Plan dev environment"
	@echo "  make plan-staging - Plan staging environment"
	@echo "  make plan-prod    - Plan production environment"
	@echo "  make destroy-dev  - Destroy dev environment"
	@echo "  make destroy-staging - Destroy staging environment"
	@echo "  make destroy-prod - Destroy production environment"
	@echo "  make init-dev     - Initialize dev environment"
	@echo "  make init-staging - Initialize staging environment"
	@echo "  make init-prod    - Initialize production environment"
	@echo "  make validate-dev - Validate dev environment"
	@echo "  make validate-staging - Validate staging environment"
	@echo "  make validate-prod - Validate production environment"
	@echo "  make clean        - Remove all .terraform directories"
	@echo "  make fmt          - Format all Terraform files"

dev:
	@cd environments/dev && terraform init && terraform apply -auto-approve

staging:
	@cd environments/staging && terraform init && terraform apply -auto-approve

prod:
	@cd environments/prod && terraform init && terraform apply -auto-approve

plan-dev:
	@cd environments/dev && terraform plan

plan-staging:
	@cd environments/staging && terraform plan

plan-prod:
	@cd environments/prod && terraform plan

destroy-dev:
	@cd environments/dev && terraform destroy -auto-approve

destroy-staging:
	@cd environments/staging && terraform destroy -auto-approve

destroy-prod:
	@cd environments/prod && terraform destroy -auto-approve

init-dev:
	@cd environments/dev && terraform init

init-staging:
	@cd environments/staging && terraform init

init-prod:
	@cd environments/prod && terraform init

validate-dev:
	@cd environments/dev && terraform validate

validate-staging:
	@cd environments/staging && terraform validate

validate-prod:
	@cd environments/prod && terraform validate

clean:
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@find . -type f -name "terraform.tfstate*" -delete 2>/dev/null || true

fmt:
	@terraform fmt -recursive

output-dev:
	@cd environments/dev && terraform output

output-staging:
	@cd environments/staging && terraform output

output-prod:
	@cd environments/prod && terraform output