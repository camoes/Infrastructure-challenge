output "lambda_producer" {
  value = aws_s3_bucket_object.producer.id
}

output "lambda_consumer" {
  value = aws_s3_bucket_object.consumer.id
}