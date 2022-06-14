 output "Bucket_Direction" {
     value = aws_s3_bucket.myapp.website_endpoint
 }

 output "apigw_Direction" {
  value = aws_apigatewayv2_api.myapp.api_endpoint
}

 output "apigw_Direction_function1" {
  value = "${aws_apigatewayv2_api.myapp.api_endpoint}/lambda1"
}

 output "apigw_Direction_function2" {
  value = "${aws_apigatewayv2_api.myapp.api_endpoint}/lambda2"
}
