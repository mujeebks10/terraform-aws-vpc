aws_region               = "us-east-1"
environment              = "prod"
project_name             = "myapp"
vpc_cidr                 = "10.2.0.0/16"
public_subnet_cidrs      = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_app_subnet_cidrs = ["10.2.10.0/24", "10.2.11.0/24", "10.2.12.0/24"]
private_db_subnet_cidrs  = ["10.2.20.0/24", "10.2.21.0/24", "10.2.22.0/24"]
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
app_port                 = 8080
db_port                  = 3306
allowed_ssh_cidrs        = ["203.0.113.0/24"]
enable_bastion           = true
enable_flow_logs         = true
enable_s3_endpoint       = true
enable_dynamodb_endpoint = true

# EC2 Instance Configurations
instance_type         = "t2.micro"
bastion_instance_type = "t2.micro"
