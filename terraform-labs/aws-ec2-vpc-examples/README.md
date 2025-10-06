# AWS EC2 Example (Terraform)

This example demonstrates how to create a simple AWS EC2 instance using Terraform.

## 📋 Prerequisites
- Terraform installed (`>= 1.3`)
- AWS account and configured CLI credentials
- Existing EC2 key pair (for SSH access)

## 🗂️ Files
- `main.tf` — Defines provider and EC2 resource
- `variables.tf` — Input variables (region, instance type, etc.)
- `outputs.tf` — Displays outputs like instance ID and public IP

## 🚀 Usage
```bash
terraform init
terraform fmt 
terraform validate
terraform plan 
terraform apply
terraform destroy
