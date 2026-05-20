# Clone/Make the directory structure
mkdir -p terraform-aws-vpc/{environments/{dev,staging,prod},modules/vpc,global/iam,scripts}

# Make scripts executable
chmod +x scripts/*.sh

# Initialize dev environment
./scripts/init-env.sh dev

# Deploy dev environment
./scripts/deploy-env.sh dev true

# Or using Make
make dev

# Check outputs
cd environments/dev
terraform output

# Destroy when done
./scripts/destroy-env.sh dev true