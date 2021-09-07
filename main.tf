# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  backend "s3" {
    bucket         = "vimcar-challenge-tfestate-cmontesinos"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "aws-locks-cmontesinos"
    encrypt        = true
  }
}
module "s3" {
  source = "./modules/s3"
}
module "lambdas" {
  source                    = "./modules/lambdas"
  source_code_hash_producer = archive_file.lambda_producer_file.output_base64sha256

}

//module "apigateway" {
//  source = "./modules/apigateway"
//}


//module "cloudwatch" {
//  source = "./modules/cloudwatch-metrics"
//}


