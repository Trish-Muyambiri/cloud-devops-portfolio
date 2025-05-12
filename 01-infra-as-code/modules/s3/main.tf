resource "aws_s3_bucket" "file_upload_bucket" {
  bucket = "${var.bucket_prefix}-${var.environment}"

  tags = {
    Name        = "${var.bucket_prefix}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "file_upload_acl" {
  bucket = aws_s3_bucket.file_upload_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "file_upload_bucket_versioning" {
  bucket = aws_s3_bucket.file_upload_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "file_upload_ownership" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_kms_key" "file_upload_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket_server_side_encryption_configuration" "file_upload_SSE" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.file_upload_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "file_upload_access" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "upload_bucket_policy" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      # Lambda Access
      {
        Sid       = "AllowLambdaToAccessBucket"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda_execution_role"
        }
        Action    = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource  = "${aws_s3_bucket.file_upload_bucket.arn}/*"
      },
      # Textract Access
      {
        Sid       = "AllowTextractToReadBucket"
        Effect    = "Allow"
        Principal = {
          Service = "textract.amazonaws.com"
        }
        Action    = [
          "s3:GetObject"
        ]
        Resource  = "${aws_s3_bucket.file_upload_bucket.arn}/*"
      }
    ]
  })
}


resource "aws_s3_bucket_lifecycle_configuration" "upload_bucket_lifecycle" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  # Transition to Glacier after 30 days
  rule {
    id     = "GlacierTransition"
    status = "Enabled"

    filter {
      prefix = ""  # Apply to all objects
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  # Permanently delete objects after 365 days
  rule {
    id     = "ExpireOldObjects"
    status = "Enabled"

    filter {
      prefix = ""  # Apply to all objects
    }

    expiration {
      days = 365
    }
  }

  # Clean up incomplete multipart uploads after 7 days
  rule {
    id     = "AbortIncompleteMultipartUploads"
    status = "Enabled"

    filter {
      prefix = ""  # Apply to all multipart uploads
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
data "aws_caller_identity" "current" {}
