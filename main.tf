terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "aws-terraform-remote-state-storage-rm"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-terraform-remote-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  profile = "default"
  region  = var.root_region
}

module "dynamodb" {
  source = "./dynamodb"
}

module "lambda_gateway" {
  source = "./lambda_gateway"
}


