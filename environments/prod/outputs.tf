# outputs.tf

output "aws_region" {
  description = "AWS region used for deployment"
  value       = var.aws_region
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "random_suffix" {
  description = "Random suffix used for resource naming"
  value       = random_string.suffix.result
}

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

# Public Subnets
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  value       = var.public_subnet_cidrs
}

# Private App Subnets
output "private_app_subnet_ids" {
  description = "List of private application subnet IDs"
  value       = module.vpc.private_app_subnet_ids
}

output "private_app_subnet_cidrs" {
  description = "List of private application subnet CIDRs"
  value       = var.private_app_subnet_cidrs
}

# Private DB Subnets
output "private_db_subnet_ids" {
  description = "List of private database subnet IDs"
  value       = module.vpc.private_db_subnet_ids
}

output "private_db_subnet_cidrs" {
  description = "List of private database subnet CIDRs"
  value       = var.private_db_subnet_cidrs
}

# Internet Gateway
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

# NAT Gateways
output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.nat_gateway_ids
}


# # VPC Endpoints
# output "s3_vpc_endpoint_id" {
#   description = "S3 VPC endpoint ID"
#   value       = module.vpc.s3_vpc_endpoint_id
# }

# output "dynamodb_vpc_endpoint_id" {
#   description = "DynamoDB VPC endpoint ID"
#   value       = module.vpc.dynamodb_vpc_endpoint_id
# }

# Flow Logs
output "vpc_flow_log_id" {
  description = "VPC Flow Log ID"
  value       = module.vpc.vpc_flow_log_id
}

# Availability Zones
output "availability_zones" {
  description = "Availability zones used"
  value       = var.availability_zones
}