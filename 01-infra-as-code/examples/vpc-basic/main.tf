provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name = "dev-vpc"

  # Provide values for the required variables
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]  # Example AZs
  vpc_cidr_block            = "10.0.0.0/16"  # Example CIDR block
  project_name              = "my-project"  # Example project name
  public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]  # Example public subnets
  private_subnet_cidrs      = ["10.0.3.0/24", "10.0.4.0/24"]  # Example private subnets
  tags                      = { "Environment" = "dev" }  # Example tags
  enable_nat_gateway        = true  # Example NAT Gateway setting
}
