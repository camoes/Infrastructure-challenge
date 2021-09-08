terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "vimcar-challenge-tfestate-cmontesinos"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "aws-locks-cmontesinos"
    encrypt        = true

  }
  required_version = ">=0.12.13"
}
module "s3_vimcar" {
  source = "./modules/s3_vimcar"
  provider = aws
}

module "lambdas_vimcar" {
  provider = aws
  source                    = "./modules/lambdas_vimcar"
  lambda_bucket_producer    = module.s3_vimcar.lambda_producer
  lambda_bucket_consumer    = module.s3_vimcar.lambda_consumer
  source_code_hash_consumer = module.s3_vimcar.lambda_consumer_file
  source_code_hash_producer = module.s3_vimcar.lambda_producer_file

}

//module "apigateway" {
//  source = "./modules/apigateway"
//}


//module "cloudwatch" {
//  source = "./modules/cloudwatch-metrics"
//}

