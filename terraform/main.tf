
provider "aws" {
  region = "us-east-1"
  access_key = "test"
  secret_key = "test"
  s3_force_path_style = true
  # endpoint = "http://localhost:4566"
  skip_credentials_validation = true
  skip_requesting_account_id = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
  }
}





module "sqs_services" {
  source = "../modules/sqs"
  subscriber_name = var.subscriber_name
}


