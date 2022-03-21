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
  region  = var.bucket_region
}

resource "aws_s3_bucket" "aws-apitest-lambda" {
  bucket        = var.bucket_name
  acl           = var.privacy
  force_destroy = "true"
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.aws-apitest-lambda.id
  key    = "index.zip"
  acl    = var.privacy
  source = "${path.root}/index.zip"
}

output "bucket_id" {
  value = aws_s3_bucket.aws-apitest-lambda.id
}

output "bucket_object_id" {
  value = aws_s3_bucket_object.index.id
}
