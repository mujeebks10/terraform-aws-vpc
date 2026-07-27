variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private app subnets"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private db subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "db_replication_port" {
  description = "Database replication port"
  type        = number
  default     = 3307
}

variable "db_admin_port" {
  description = "Database admin port (e.g., 3306 for MySQL, 5432 for PostgreSQL)"
  type        = number
  default     = 3306
}

variable "metrics_port" {
  description = "Metrics port for monitoring"
  type        = number
  default     = 9090
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "myapp"
}

# variable "random_suffix" {
#   description = "Random suffix for unique naming"
#   type        = string
# }

variable "random_suffix" {
  description = "Random suffix for unique naming"
  type        = string
  default     = null
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "monitoring_cidrs" {
  description = "CIDR blocks allowed for monitoring"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "enable_bastion" {
  description = "Enable bastion host security group"
  type        = bool
  default     = false
}

variable "enable_vpc_peering" {
  description = "Enable VPC peering routes"
  type        = bool
  default     = false
}

variable "peered_vpc_cidr" {
  description = "CIDR of peered VPC"
  type        = string
  default     = ""
}

variable "vpc_peering_id" {
  description = "ID of VPC peering connection"
  type        = string
  default     = ""
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Retention days for flow logs"
  type        = number
  default     = null
}

variable "enable_s3_endpoint" {
  description = "Enable S3 VPC endpoint"
  type        = bool
  default     = true
}

variable "enable_dynamodb_endpoint" {
  description = "Enable DynamoDB VPC endpoint"
  type        = bool
  default     = true
}