terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source        = "./modules/s3"
  bucket_prefix = var.bucket_prefix
  environment   = var.environment
}
