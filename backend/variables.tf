variable "backend_region" {
  type    = string
  default = "us-east-1"
}

variable "backend_bucket_name" {
  type    = string
  default = "aws-terraform-remote-state-storage-for-backend-api-project"
}

variable "encryption_algorithm" {
  type    = string
  default = "AES256"
}

variable "dynamodb_terraform_name" {
  type    = string
  default = "aws-terraform-remote-state-locks-for-backend-api-project"
}

variable "dynamodb_terraform_billing_mode" {
  type      = string
  default   = "PAY_PER_REQUEST"
  sensitive = true
}


