
output "function_name" {
  description = "Name of the Lambda function producer."

  value = aws_lambda_function.producer.function_name
}

output "function_name" {
  description = "Name of the Lambda function consumer."

  value = aws_lambda_function.consumer.function_name
}