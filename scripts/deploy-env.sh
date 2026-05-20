#!/bin/bash

# Deploy Terraform for specific environment
ENV=$1
AUTO_APPROVE=${2:-false}

if [ -z "$ENV" ]; then
    echo "Usage: $0 <environment> [auto-approve]"
    echo "Environments: dev, staging, prod"
    echo "auto-approve: true/false (default: false)"
    exit 1
fi

if [[ ! "$ENV" =~ ^(dev|staging|prod)$ ]]; then
    echo "Error: Environment must be dev, staging, or prod"
    exit 1
fi

cd "environments/$ENV" || exit 1

echo "Deploying to $ENV environment..."

# Initialize if needed
if [ ! -d ".terraform" ]; then
    terraform init
fi

# Validate
terraform validate

# Plan
echo "Creating plan..."
terraform plan -out=tfplan

# Apply
if [ "$AUTO_APPROVE" = "true" ]; then
    echo "Applying with auto-approve..."
    terraform apply -auto-approve tfplan
else
    echo "Review the plan and apply:"
    echo "terraform apply tfplan"
fi

echo ""
echo "Deployment complete for $ENV environment!"