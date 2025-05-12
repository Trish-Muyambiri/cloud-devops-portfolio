variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "scalable-file-upload"
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}

variable "bucket_prefix" {
  description = "The prefix for the S3 bucket"
  type        = string
}

