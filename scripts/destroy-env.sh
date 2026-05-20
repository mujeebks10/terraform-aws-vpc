#!/bin/bash

# Destroy Terraform resources for specific environment
ENV=$1
AUTO_APPROVE=${2:-false}

if [ -z "$ENV" ]; then
    echo "Usage: $0 <environment> [auto-approve]"
    echo "Environments: dev, staging, prod"
    exit 1
fi

if [[ ! "$ENV" =~ ^(dev|staging|prod)$ ]]; then
    echo "Error: Environment must be dev, staging, or prod"
    exit 1
fi

cd "environments/$ENV" || exit 1

echo "WARNING: You are about to destroy the $ENV environment!"
echo "This action cannot be undone!"

if [ "$AUTO_APPROVE" != "true" ]; then
    read -p "Are you sure? Type 'yes' to continue: " CONFIRM
    if [ "$CONFIRM" != "yes" ]; then
        echo "Aborted."
        exit 1
    fi
fi

echo "Destroying $ENV environment..."

terraform destroy ${AUTO_APPROVE:+-auto-approve}

echo ""
echo "Destroy complete for $ENV environment!"