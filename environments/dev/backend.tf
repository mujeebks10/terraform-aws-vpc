terraform {
  backend "s3" {
    bucket         = "myapp01-terraform-state-dev"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    #dynamodb_table = "myapp-terraform-locks-dev"
    use_lockfile = true
  }
}