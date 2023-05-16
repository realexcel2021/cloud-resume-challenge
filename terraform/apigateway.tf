resource "aws_apigatewayv2_api" "lambda_api" {
    name = "Veiw-Count-API"
    protocol_type = "HTTP"

    cors_configuration {
      allow_origins = ["*"]
    }
}

resource "aws_cloudwatch_log_group" "main_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.lambda_api.name}"

  retention_in_days = 3
}

resource "aws_apigatewayv2_stage" "lambda_api_stage" {
    api_id = aws_apigatewayv2_api.lambda_api.id
    name = "dev"
    auto_deploy = true

    access_log_settings {
      destination_arn = aws_cloudwatch_log_group.main_api_gw.arn

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

resource "aws_apigatewayv2_integration" "lambda_api_int" {
    api_id = aws_apigatewayv2_api.lambda_api.id

    integration_uri = aws_lambda_function.write_to_table.invoke_arn
    integration_type = "AWS_PROXY"
    integration_method = "POST"
}

resource "aws_apigatewayv2_route" "lambda_api_route" {
    api_id = aws_apigatewayv2_api.lambda_api.id

    route_key = "POST /views"
    target = "integrations/${aws_apigatewayv2_integration.lambda_api_int.id}"
}

resource "aws_lambda_permission" "lambda_api_per" {
    statement_id = "AllowExecutionFromAPIGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.write_to_table.function_name
    principal = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}