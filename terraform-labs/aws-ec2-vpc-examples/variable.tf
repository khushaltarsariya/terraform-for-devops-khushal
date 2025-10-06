variable "aws_region_name" {
  description = "defining the name of the instance"
  type        = string
  default     = "us-east-1"
}

variable "aws_instance_name" {
  description = "defining the name of the ec2 instnace"
  type        = string
  default     = "my_ec2"
}

variable "aws_instance_ami_id" {
  description = "defining the id of the ec2 instnace"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "aws_instance_type" {
  description = "defining the type of ec2 instance"
  type        = string
  default     = "t2.micro"
}

variable "aws_ssh_key" {
  description = "defining the name of the key"
  type        = string
  default     = "mainkey"
}

