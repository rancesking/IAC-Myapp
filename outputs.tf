 output "Bucket_Direction" {
     value = aws_s3_bucket.myapp.website_endpoint
 }

 output "lambda1_Direction" {
     value = aws_lambda_function.lambda1.invoke_arn
 }

 output "lambda2_Direction" {
     value = aws_lambda_function.lambda1.invoke_arn
 }

 output "apigw_Direction" {
  value = aws_apigatewayv2_api.myapp.api_endpoint
}