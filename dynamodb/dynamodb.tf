terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.dynamodb_region
}

resource "aws_dynamodb_table" "pets" {
  name           = var.db_name
  hash_key       = "id"
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  attribute {
    name = "id"
    type = "S"
  }
}

