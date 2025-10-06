variable "aws_region" {
  description = "name of the region"
  type        = string
  default     = "us-east-1"
}

variable "aws_bucket_name" {
  description = "name of the bucket"
  type        = string
  default     = "khushal-s3-bucket-1408"
}

variable "aws_s3_bucket_versioning_enable" {
  description = "enable the bucket versoning"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "blocking the public access"
  type        = bool
  default     = true
}