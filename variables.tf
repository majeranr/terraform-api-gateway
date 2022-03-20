variable "root_region" {
  type    = string
  default = "us-east-1"
}

variable "dynamodb_terraform_name" {
  type    = string
  default = "aws-terraform-remote-state-locks"
}

