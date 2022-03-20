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
  region  = var.lambda_gateway_region
}

module "bucket" {
  source = "../bucket"
}

resource "aws_iam_role" "lambda_apigateway" {
  name               = var.iam_role_name
  assume_role_policy = file("${path.root}/assume_role_policy.json")
}


resource "aws_iam_role_policy" "lambda_apigateway_test_policy" {
  name   = var.iam_policy_name
  role   = aws_iam_role.lambda_apigateway.id
  policy = file("${path.root}/policy.json")
}

resource "aws_lambda_function" "lambda_api_test" {

  function_name = var.lambda_function_name
  s3_bucket     = module.bucket.bucket_id
  s3_key        = module.bucket.bucket_object_id
  role          = aws_iam_role.lambda_apigateway.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
}

resource "aws_api_gateway_rest_api" "api_for_test" {
  name        = var.rest_api_name
  description = var.rest_api_description
}

resource "aws_api_gateway_resource" "post" {
  rest_api_id = aws_api_gateway_rest_api.api_for_test.id
  parent_id   = aws_api_gateway_rest_api.api_for_test.root_resource_id
  path_part   = var.resource_name
}

resource "aws_api_gateway_method" "request_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_for_test.id
  resource_id   = aws_api_gateway_resource.post.id
  http_method   = var.http_method
  authorization = var.authorization
}

resource "aws_api_gateway_integration" "request_method_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_for_test.id
  resource_id             = aws_api_gateway_resource.post.id
  http_method             = aws_api_gateway_method.request_method.http_method
  integration_http_method = var.integration_http_method
  type                    = var.integration_type
  uri                     = aws_lambda_function.lambda_api_test.invoke_arn
}

resource "aws_api_gateway_method_response" "response_method" {
  rest_api_id = aws_api_gateway_rest_api.api_for_test.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = aws_api_gateway_integration.request_method_integration.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "response_method_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_for_test.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = aws_api_gateway_method_response.response_method.http_method
  status_code = aws_api_gateway_method_response.response_method.status_code
  response_templates = {
    "application/json" = ""
  }
  depends_on = [aws_api_gateway_integration.request_method_integration]
}

resource "aws_api_gateway_deployment" "API_gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.request_method_integration,
    aws_api_gateway_integration_response.response_method_integration,
  ]
  rest_api_id = aws_api_gateway_rest_api.api_for_test.id
  stage_name  = var.stage_name
}

resource "aws_lambda_permission" "apigwperm" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_api_test.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_for_test.execution_arn}/*/*"
  depends_on = [
    aws_api_gateway_rest_api.api_for_test,
    aws_api_gateway_resource.post,
  ]
}

