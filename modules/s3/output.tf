output "lambda_producer" {
  value = aws_s3_bucket.producer.id
}

output "lambda_consumer" {
  value = aws_s3_bucket.consumer.id
}