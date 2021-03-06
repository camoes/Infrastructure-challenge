terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "challenge-tfestate-cmontesinos"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true

  }
  required_version = ">=0.12.13"
}
module "s3" {
  source = "./modules/s3"
}

module "lambdas" {

  source                    = "./modules/lambdas_"
  lambda_bucket_producer    = module.s3.lambda_producer
  lambda_bucket_consumer    = module.s3.lambda_consumer
  lambda_consumer_key_file  = module.s3.lambda_consumer_key_file
  lambda_producer_key_file  = module.s3.lambda_producer_key_file
  source_code_hash_consumer = module.s3.lambda_consumer_file
  source_code_hash_producer = module.s3.lambda_producer_file

}

module "apigateway" {
  source                     = "./modules/apigateway"
  function_name_producer     = module.lambdas.function_name_producer
  function_name_producer_arn = module.lambdas.function_name_producer_arn
}


module "cloudwatch" {
  source             = "./modules/cloudwatch-metrics"
  cloudwatch_lambdas = module.lambdas.cloudwatch_lambdas
  cloudwatch_api     = module.apigateway.cloudwatch_api

}

