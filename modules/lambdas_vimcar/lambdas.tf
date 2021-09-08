provider "aws" {
  region = var.aws_region
}
resource "aws_lambda_function" "producer" {
  function_name = "producer_lambda"

  s3_key = var.lambda_producer_key_file
  s3_bucket = var.lambda_bucket_producer
  source_code_hash = var.source_code_hash_producer

  handler          = "${var.handler}"
  runtime          = "${var.runtime}"

  role = aws_iam_role.lambda_exec.arn
}
resource "aws_lambda_function" "consumer" {
  function_name = "consumer_lambda"
  
  s3_key = var.lambda_consumer_key_file
  s3_bucket = var.lambda_bucket_consumer
  source_code_hash = var.source_code_hash_consumer


  handler          = "${var.handler}"
  runtime          = "${var.runtime}"

  role = aws_iam_role.lambda_exec.arn
}
resource "aws_cloudwatch_log_group" "producer" {
  name = "/aws/lambda/${aws_lambda_function.producer.function_name}"

  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "consumer" {
  name = "/aws/lambda/${aws_lambda_function.consumer.function_name}"

  retention_in_days = 30
}
