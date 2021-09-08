provider "aws" {
  region = var.aws_region
}
resource "aws_api_gateway_rest_api" "lambda" {
  name = "serverless_lambda_gw"
}

resource "aws_api_gateway_resource" "the" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  parent_id   = aws_api_gateway_rest_api.lambda.root_resource_id
  path_part   = "example"
}

resource "aws_api_gateway_model" "the" {
  rest_api_id  = aws_api_gateway_rest_api.lambda.id
  name         = "POSTExampleRequestModelExample"
  description  = "A JSON schema"
  content_type = "application/json"
  schema       = file("${path.cwd}/files/api_gateway_body_mapping.json")
}
resource "aws_api_gateway_request_validator" "the" {
  name                        = "POSTExampleRequestValidator"
  rest_api_id                 = aws_api_gateway_rest_api.lambda.id
  validate_request_body       = true
  validate_request_parameters = false
}

resource "aws_api_gateway_method" "the" {
  rest_api_id          = aws_api_gateway_rest_api.lambda.id
  resource_id          = aws_api_gateway_resource.the.id
  authorization        = "NONE"
  http_method          = "POST"
  request_validator_id = aws_api_gateway_request_validator.the.id

  request_models = {
    "application/json" = aws_api_gateway_model.the.name
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  resource_id = aws_api_gateway_resource.the.id
  http_method = aws_api_gateway_method.the.http_method
  status_code = "200"
}


// we check the request is in the desired json format 
resource "aws_api_gateway_integration" "producer_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  resource_id = aws_api_gateway_resource.the.id
  http_method = aws_api_gateway_method.the.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.function_name_producer_arn
}

//Route the response to the ProducerLambda function
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_api_gateway_rest_api.lambda.name}"

  retention_in_days = 30
}
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "producer_lambda"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.lambda.execution_arn}/*/*/*"
}

//
