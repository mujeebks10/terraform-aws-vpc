#!/bin/bash

# Initialize Terraform for specific environment
ENV=$1

if [ -z "$ENV" ]; then
    echo "Usage: $0 <environment>"
    echo "Environments: dev, staging, prod"
    exit 1
fi

if [[ ! "$ENV" =~ ^(dev|staging|prod)$ ]]; then
    echo "Error: Environment must be dev, staging, or prod"
    exit 1
fi

cd "environments/$ENV" || exit 1

echo "Initializing Terraform for $ENV environment..."

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt

echo ""
echo "Initialization complete for $ENV environment!"
echo "To plan: cd environments/$ENV && terraform plan"
echo "To apply: cd environments/$ENV && terraform apply"