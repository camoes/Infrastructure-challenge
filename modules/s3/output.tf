output "lambda_producer" {
  value = aws_s3_bucket.lambada_bucket_producer.id
}

output "lambda_consumer" {
  value = aws_s3_bucket.lambada_bucket_consumer.id
}