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

#Step 5 -Add s3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#Step-6 create an iam role for ec2
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-upload-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal  = {
                Service = "ec2.amazonaws.com"
            },
            
        }
    ]
  })
}

#Step-7 create an iam policy for s3 access 
resource "aws_iam_policy" "s3_upload_policy" {
  name = "s3_upload_policy"
  description = "Allow ec2 instnce to upload image to s3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:ListBucket"
         ],
         Resource = [
            aws_s3_bucket.main.arn,
            "${aws_s3_bucket.main.arn}/*"
         ]
        }
    ]
  })
}

#attcting the policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_upload_policy.arn
}

#Step-8 create iam instnace profile for ec2
#Usage: When launching EC2 instances (your private Laravel/Node.js servers), attach this instance profile so your app can upload images securely using AWS SDK without needing static credentials.
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}

#Step-9 Enable server side encryption
#Why: Encryption ensures data protection even if the bucket is accidentally exposed.
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}