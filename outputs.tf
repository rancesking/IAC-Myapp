 output "Bucket_Direction" {
     value = aws_s3_bucket.myapp.website_endpoint
 }

 output "lambda_Direction" {
     value = aws_lambda_function.lambda1.invoke_arn
 }

 output "base_url" {
  value = "${aws_api_gateway_deployment.example.invoke_url}"
}