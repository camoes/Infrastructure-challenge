resource "random_pet" "lambda_bucket_name" {
  
    # Generate a new pet name each time we switch to a new bucket id
  prefix = "vimcar-challenge"
  length = 4
  
}
resource "aws_s3_bucket" "lambda_bucket_producer" {
  bucket = random_pet.lambda_bucket_name.id

  acl           = "private"
  force_destroy = true
}

data "archive_file" "lambda_producer" {
  type = "zip"

  source_dir  = "../files/producer"
  output_path = "../files/producer.zip"
}

resource "aws_s3_bucket_object" "lambda_producer" {
  bucket = aws_s3_bucket.lambda_bucket_name.id

  key    = "producer.zip"
  source = data.archive_file.lambda_producer.output_path

  etag = filemd5(data.archive_file.lambda_producer.output_path)
}
resource "aws_s3_bucket" "lambda_bucket_consumer" {
  bucket = random_pet.lambda_bucket_name.id

  acl           = "private"
  force_destroy = true
}
data "archive_file" "lambda_consumer" {
  type = "zip"

  source_dir  = "../files/consumer"
  output_path = "../files/consumer.zip"
}

resource "aws_s3_bucket_object" "lambda_consumer" {
  bucket = aws_s3_bucket.lambda_bucket_name.id

  key    = "consumer.zip"
  source = data.archive_file.lambda_consumer.output_path

}