output "Lambda_bucket_producer_name" {
  description = "ARN of the bucket"
  value       = module.s3_vimcar.lambda_producer
}

output "Lambda_bucket_consumer_name" {
  description = "Name (id) of the bucket"
  value       = module.s3_vimcar.lambda_consumer
}

output "Lambda_file_hash_consumer" {
  description = "Domain name of the bucket"
  value       = module.s3_vimcar.lambda_consumer_file
}

output "Lambda_file_hash_producer" {
  description = "Domain name of the bucket"
  value       = module.s3_vimcar.lambda_producer_file
}