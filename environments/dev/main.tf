terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

# Provider configuration for the environment
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  # AWS Configuration
  aws_region = var.aws_region
  
  # Environment Configuration
  environment   = var.environment
  project_name  = var.project_name
  random_suffix = random_string.suffix.result
  
  # Network Configuration
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  availability_zones    = var.availability_zones
  
  # Port Configuration
  app_port = var.app_port
  db_port  = var.db_port
  
  # Security Configuration
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  enable_bastion    = var.enable_bastion
  
  # Feature Flags
  enable_flow_logs       = var.enable_flow_logs
  enable_s3_endpoint     = var.enable_s3_endpoint
  enable_dynamodb_endpoint = var.enable_dynamodb_endpoint
}