#Define the provider here since for the we are using the Aws provider
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region_name
}


#create Ec2 instance

resource "aws_instance" "my_ec2" {
  ami           = var.aws_instance_ami_id
  instance_type = var.aws_instance_type
  key_name      = var.aws_ssh_key

  tags = {
    Name = var.aws_instance_name
  }
}