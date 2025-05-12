variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}
