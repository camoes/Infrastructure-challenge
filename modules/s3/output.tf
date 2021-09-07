output "lambda_producer" {
  value = aws_s3_bucket.lambda_bucket_producer.id
}

output "lambda_consumer" {
  value = aws_s3_bucket.lambda_bucket_consumer.id
}

output "lambda_producer_file" {
  value = archive_file.lambda_producer_file
}
output "lambda_consumer_file" {
  value = archive_file.lambda_consumer_file
}