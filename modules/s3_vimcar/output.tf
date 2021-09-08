output "lambda_producer" {
  value = aws_s3_bucket.lambda_bucket_producer.id
}

output "lambda_consumer" {
  value = aws_s3_bucket.lambda_bucket_consumer.id
}

output "lambda_producer_key_file" {
  value = aws_s3_bucket_object.lambda_producer_object.id
}
output "lambda_consumer_key_file" {
  value = aws_s3_bucket_object.lambda_consumer_object.id
}
output "lambda_producer_file" {
  value = data.archive_file.lambda_producer_file.output_base64sha256
}
output "lambda_consumer_file" {
  value = data.archive_file.lambda_consumer_file.output_base64sha256
}