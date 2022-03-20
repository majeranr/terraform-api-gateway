variable "db_name" {
  description = "Choose name for DynamoDB table"
  type        = string
  default     = "Pets"
}

variable "billing_mode" {
  type      = string
  default   = "PROVISIONED"
  sensitive = true
}

variable "read_capacity" {
  type    = number
  default = 1
}

variable "write_capacity" {
  type    = number
  default = 1
}

variable "dynamodb_region" {
  description = "Choose the region to deploy DynamoDB, should be same as other services"
  type        = string
  default     = "us-east-1"
}
