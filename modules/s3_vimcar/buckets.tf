
provider "aws" {
  region = var.aws_region
}
resource "aws_s3_bucket" "lambda_bucket_producer" {
  bucket = "lambda-bucket-producer"

  acl           = "private"
  force_destroy = true
}

data "archive_file" "lambda_producer_file" {
  type = "zip"

  source_dir  = "${path.module}/files/producer.py"
  output_path = "${path.module}/files/producer.zip"
}

resource "aws_s3_bucket_object" "lambda_producer_object" {
  bucket = aws_s3_bucket.lambda_bucket_producer.id

  key    = "producer.zip"
  source = data.archive_file.lambda_producer_file.output_path
  etag = filemd5(data.archive_file.lambda_producer_file.output_path)
}
resource "aws_s3_bucket" "lambda_bucket_consumer" {
  bucket = "lambda-bucket-consumer"

  acl           = "private"
  force_destroy = true
}
data "archive_file" "lambda_consumer_file" {
  type = "zip"

  source_dir  = "${path.module}/files/consumer.py"
  output_path = "${path.module}/files/consumer.zip"
}

resource "aws_s3_bucket_object" "lambda_consumer_object" {
  bucket = aws_s3_bucket.lambda_bucket_consumer.id

  key    = "consumer.zip"
  source = data.archive_file.lambda_consumer_file.output_path
  etag   = filemd5(data.archive_file.lambda_consumer_file.output_path)


}