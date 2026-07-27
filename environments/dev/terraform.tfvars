#aws_region              = "us-east-1"
aws_region               = "us-east-1"
environment              = "dev"
project_name             = "myapp"
vpc_cidr                 = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_app_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
private_db_subnet_cidrs  = ["10.0.20.0/24", "10.0.21.0/24"]
availability_zones       = ["us-east-1a", "us-east-1b"]
app_port                 = 8080
db_port                  = 3306
allowed_ssh_cidrs        = ["203.0.113.0/24"]
enable_bastion           = false
enable_flow_logs         = true
enable_s3_endpoint       = true
enable_dynamodb_endpoint = true

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]


