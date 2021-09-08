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


resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_api_gateway_rest_api.lambda.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

//Configure log format for the request to the apigateway
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_api_gateway_model" "the" {
  rest_api_id  = aws_api_gateway_rest_api.lambda.id
  name         = "POSTExampleRequestModelExample"
  description  = "A JSON schema"
  content_type = "application/json"
  schema       = file("${path.root}/files/api_gateway_body_mapping.json")
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
resource "aws_apigatewayv2_integration" "producer_integration" {
  api_id = aws_api_gateway_rest_api.lambda.id
  integration_uri    = var.function_name_producer_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

//Route the response to the ProducerLambda function
resource "aws_apigatewayv2_route" "producer_route" {
  api_id = aws_api_gateway_rest_api.lambda.id

  route_key = "$default" //This should be changed for the desired endpoint to trigger de request for the lambda, which hasn't been defined 
  target    = "integrations/${aws_apigatewayv2_integration.producer_integration.id}"
}
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_api_gateway_rest_api.lambda.name}"

  retention_in_days = 30
}
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name_producer
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.lambda.arn}/*/*"
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  stage_name  = aws_apigatewayv2_stage.lambda.name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

//
