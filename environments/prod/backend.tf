terraform {
  backend "s3" {
    bucket         = "myapp-terraform-state-prod"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "myapp-terraform-locks-prod"
  }
}