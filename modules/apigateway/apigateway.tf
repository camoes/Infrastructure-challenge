resource "aws_apigatewayv2_api" "lambda" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

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

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

  retention_in_days = 30
}
data "aws_lambda_function" "producer" {
  id = var.lambda_id
}
// we check the request is in the desired json format 
resource "aws_apigatewayv2_integration" "producer" {
  source = "../lambdas/lambdas.tf"
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri    = aws_lambda_function.producer.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  request_templates = {                  # Specifing desired json format
    "application/json" = "${file("../files/api_gateway_body_mapping.json")}"
  }
}

resource "aws_api_gateway_request_validator" "producer" {
  name                        = "POSTProducerRequestValidator"
  rest_api_id                 = aws_api_gateway_rest_api.producer.id
  validate_request_body       = true
  validate_request_parameters = false
}

//Route the response to the ProducerLambda function
resource "aws_apigatewayv2_route" "producer" {
  source = "../lambdas/lambdas.tf"
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "$default" //This should be changed for the desired endpoint to trigger de request for the lambda, which hasn't been defined 
  target    = "integrations/${aws_apigatewayv2_integration.producer.id}"
}


resource "aws_lambda_permission" "api_gw" {
  source = "../lambdas/lambdas.tf"
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.producer.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}
//
