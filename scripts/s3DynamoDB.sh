# Create S3 buckets
aws s3 mb s3://myapp-terraform-state-dev --region us-east-1
aws s3 mb s3://myapp-terraform-state-staging --region us-east-1
aws s3 mb s3://myapp-terraform-state-prod --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning --bucket myapp-terraform-state-dev --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket myapp-terraform-state-staging --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket myapp-terraform-state-prod --versioning-configuration Status=Enabled

# Create DynamoDB tables
aws dynamodb create-table \
    --table-name myapp-terraform-locks-dev \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST

aws dynamodb create-table \
    --table-name myapp-terraform-locks-staging \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST

aws dynamodb create-table \
    --table-name myapp-terraform-locks-prod \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST