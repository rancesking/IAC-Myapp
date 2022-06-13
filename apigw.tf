resource "aws_apigatewayv2_api" "myapp" {
  name          = "myapp-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "myapp_lambda1" {
  api_id           = aws_apigatewayv2_api.myapp.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda integration"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.lambda1.invoke_arn
}

resource "aws_apigatewayv2_integration" "myapp_lambda2" {
  api_id           = aws_apigatewayv2_api.myapp.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda integration"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.lambda2.invoke_arn
}

resource "aws_apigatewayv2_route" "myapp_lambda1" {
  api_id    = aws_apigatewayv2_api.myapp.id
  route_key = "GET /lambda1"
  target = "integrations/${aws_apigatewayv2_integration.myapp_lambda1.id}"
}

resource "aws_apigatewayv2_route" "myapp_lambda2" {
  api_id    = aws_apigatewayv2_api.myapp.id
  route_key = "GET /lambda2"
  target = "integrations/${aws_apigatewayv2_integration.myapp_lambda2.id}"
}

resource "aws_apigatewayv2_stage" "myapp" {
  api_id = aws_apigatewayv2_api.myapp.id
  name   = "$default"
  auto_deploy = true
}
