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
  region  = var.backend_region
}

resource "aws_s3_bucket" "terraform_remote_state" {
  bucket = var.backend_bucket_name
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.encryption_algorithm
      }
    }
  }
  force_destroy = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_terraform_name
  billing_mode = var.dynamodb_terraform_billing_mode
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}




