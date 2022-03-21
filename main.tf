terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "Enter here your bucket name from backend module"
    key            = "global/s3/terraform.tfstate"
    region         = "Choose your region"
    dynamodb_table = "Enter here the name of DynamoDB table from backend module"
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


