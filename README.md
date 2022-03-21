# Terraform AWS Lambda & API Gateway

### Features

- Ready-to-test API Gateway with REST API in Python (from https://github.com/echovue/pet-api-lambda-python), only POST method included
- Terraform state stored remotely in encrypted S3 bucket
- Ready-to-use after slight customization
- All resources are included in AWS free tier so no costs should be billed

### Deployment

1. Run the `terraform init` & `terraform apply` in `backend` module first to create the S3 bucket for backend storage. This is required as backend block in Terraform does not support variables.
2. Adjust the `backend` block in `main.tf` file in `root` module to reflect your region, bucket's and DynamoDB table's details rom `backend` module
3. Adjust the `policy.json` file to reflect the details of your account, region & DynamoDB table's name
4. Create `.tfvars` file if you want to customize variables, however all of them have `default` values set up so it is not required
5. Run the `terraform init` & `terraform apply` in `root` module
6. If everything was done properly, Terraform should return information that 14 objects will be added
7. Confirm the plan with `yes` if everything is correct
8. After a while, all resources will be created and you are ready to test the API Gateway.

### What will it do?

1. Terraform will create the encrypted S3 bucket and keep your `.tfstate` file there
2. Then it will create S3 bucket & upload `index.zip` onto it. `index.zip` contains `index.py`.
3. Lambda function will be deployed using the `index.zip` file from created S3 bucket along with DynamoDB table required for it to work properly.
4. IAM role will be created for Lambda and appropriate IAM policy will be attached to it (see details of policy in `policy.json`)
5. An API Gateway will be created and deployed to the Lambda function, POST method & Lambda integration will be created
6. Lambda function invoking permissions will be granted to API gateway

### Additional information

Python API has been written by `echovue` from https://github.com/echovue/pet-api-lambda-python, copyrights belong to the author.
