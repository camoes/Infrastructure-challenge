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

  key    = "consumer.zip"
  source = data.archive_file.lambda_consumer.output_path

}