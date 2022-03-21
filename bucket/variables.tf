variable "bucket_name" {
  description = "Name for S3 bucket storing the Lambda function"
  type        = string
  default     = "aws-storage-lambda"
}

variable "privacy" {
  description = "Choose if bucket or object should be public or not"
  type        = string
  default     = "private"
}

variable "bucket_region" {
  description = "Choose the region where the bucket should be deployed, should be same as other services"
  type        = string
  default     = "us-east-1"
}





