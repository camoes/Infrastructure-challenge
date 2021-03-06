provider "aws" {
  region = var.aws_region
}

//Lambda definitions,
resource "aws_lambda_function" "producer" {
  function_name = "producer_lambda"

  s3_key = var.lambda_producer_key_file
  s3_bucket = var.lambda_bucket_producer
  source_code_hash = var.source_code_hash_producer

  handler          = "producer.lambda_handler"
  runtime          = "${var.runtime}"

  role = aws_iam_role.lambda_exec.arn
}
resource "aws_lambda_function" "consumer" {
  function_name = "consumer_lambda"
  
  s3_key = var.lambda_consumer_key_file
  s3_bucket = var.lambda_bucket_consumer
  source_code_hash = var.source_code_hash_consumer


  handler          = "consumer.lambda_handler"
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
//this is needed for api-gateway integration
data "aws_lambda_function" "my_function_invoke_lambda" {
  function_name = "producer_lambda"
}


resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::251673427141:policy/serveless_lambda_"
}