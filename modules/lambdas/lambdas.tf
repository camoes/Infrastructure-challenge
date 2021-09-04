resource "aws_lambda_function" "producer" {
  function_name = "lambda_producer"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_bucket_object.lambda_producer.key

  handler          = "${var.handler}"
  runtime          = "${var.runtime}"

  source_code_hash = data.archive_file.lambda_producer.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}
resource "aws_lambda_function" "consumer" {
  function_name = "lambda_consumer"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_bucket_object.lambda_consumer.key

  handler          = "${var.handler}"
  runtime          = "${var.runtime}"

  source_code_hash = data.archive_file.lambda_consumer.output_base64sha256

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
