#Step-1
#Defining the provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#Step-2
#creating the s3 bucket
resource "aws_s3_bucket" "main" {
  bucket = var.aws_bucket_name
}

#Step-3
#versoning of bucket
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = var.aws_s3_bucket_versioning_enable ? "Enabled" : "Disabled"
  }
}

#Step-4
#Bucket policy (for the security best practice)
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}
