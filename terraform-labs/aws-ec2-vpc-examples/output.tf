output "instance_id" {
  description = "The id of the ec2_instnace"
  value       = aws_instance.my_ec2.id
}

output "public_ip" {
  description = "The public ip of the ec2 instance"
  value       = aws_instance.my_ec2.public_ip
}