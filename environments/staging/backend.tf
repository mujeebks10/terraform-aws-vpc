terraform {
  backend "s3" {
    bucket         = "myapp01-terraform-state-staging"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    #dynamodb_table = "myapp-terraform-locks-staging"
    use_lockfile = true
  }
}