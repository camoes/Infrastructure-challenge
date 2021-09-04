output "lambda_producer" {
  value = aws_lambda_function.producer.id
}

output "lambda_consumer" {
  value = aws_lambda_function.consumer.id
}
