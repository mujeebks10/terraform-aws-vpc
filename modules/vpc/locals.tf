locals {
  common_tags = {
    Environment  = var.environment
    Project      = var.project_name
    ManagedBy    = "Terraform"
    Region       = var.aws_region
    RandomSuffix = var.random_suffix
  }

  # Determine NAT Gateway count based on environment
  nat_gateway_count = var.environment == "prod" ? length(var.availability_zones) : 1

  # Flow logs retention days based on environment
  flow_logs_retention = var.flow_logs_retention_days != null ? var.flow_logs_retention_days : (
    var.environment == "prod" ? 365 : (
      var.environment == "staging" ? 90 : 30
    )
  )
}