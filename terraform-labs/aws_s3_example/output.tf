output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
