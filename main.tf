# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  backend "s3" {
    bucket         = "kyler-github-actions-demo-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-east-1"
}

//Uploading the needed scripts from within the repo, this should be settled as a different repo in the future, but that is beyond the scope of this challenge

module "s3" {
  source = "../modules/s3"
}

module "lambdas" {
  source   = "../modules/lambdas"
}


