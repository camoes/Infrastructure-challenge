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
  version = "~> 2.36.0"
}

//Uploading the needed scripts from within the repo, this should be settled as a different repo in the future, but that is beyond the scope of this challenge

data "archive_file" "lambda_producer" {
  type = "zip"

  source_dir  = "${path.module}/producer"
  output_path = "${path.module}/producer.zip"
}

resource "aws_s3_bucket_object" "lambda_producer" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "producer.zip"
  source = data.archive_file.lambda_producer.output_path

  etag = filemd5(data.archive_file.lambda_producer.output_path)
}

data "archive_file" "lambda_consumer" {
  type = "zip"

  source_dir  = "${path.module}/consumer"
  output_path = "${path.module}/consumer.zip"
}

resource "aws_s3_bucket_object" "lambda_consumer" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_consumer.output_path

}