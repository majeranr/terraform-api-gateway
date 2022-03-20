variable "lambda_gateway_region" {
  description = "Choose region where AWS Lambda & API gateway should be deployed, should be same as other services"
  type        = string
  default     = "us-east-1"
}

variable "iam_role_name" {
  type    = string
  default = "lambda_apigateway"
}

variable "iam_policy_name" {
  type    = string
  default = "lambda_apigateway_policy"
}

variable "lambda_function_name" {
  description = "Choose a name for your Lambda function"
  type        = string
  default     = "Lambda_API_Test"
}

variable "lambda_handler" {
  type    = string
  default = "index.lambda_handler"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.7"
}

variable "rest_api_name" {
  type    = string
  default = "Test API"
}

variable "rest_api_description" {
  type    = string
  default = "API created to learn the AWS API Gateways"
}

variable "resource_name" {
  type    = string
  default = "post_rsc"
}

variable "http_method" {
  type    = string
  default = "POST"
}

variable "authorization" {
  type    = string
  default = "NONE"
}

variable "integration_http_method" {
  type    = string
  default = "POST"
}

variable "integration_type" {
  type    = string
  default = "AWS"
}

variable "stage_name" {
  type    = string
  default = "test"
}
