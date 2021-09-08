//Variables used in the repo

variable "handler" {
  default = "lambda.handler"
}

variable "runtime" {
  default = "python3.6"
}

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}
variable "source_code_hash_producer" {
  type = string
}
variable "source_code_hash_consumer" {
  type = string
}
variable "lambda_bucket_consumer" {
  type = string
}

variable "lambda_bucket_producer" {
  type = string
}