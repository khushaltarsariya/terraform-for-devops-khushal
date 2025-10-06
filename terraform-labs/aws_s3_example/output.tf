output "s3_bucket_name" {
  description = "name of bucket"
  value = aws_s3_bucket.main.bucket_domain_name
}