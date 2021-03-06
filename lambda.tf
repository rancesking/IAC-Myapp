
resource "aws_iam_role" "lambda_role" {
name   = "Lambda_Function_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_lambda_permission" "apigw_lamba1" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.lambda1.function_name
   principal     = "apigateway.amazonaws.com"
   source_arn = "${aws_apigatewayv2_api.myapp.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lamba2" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.lambda2.function_name
   principal     = "apigateway.amazonaws.com"
   source_arn = "${aws_apigatewayv2_api.myapp.execution_arn}/*/*"
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "lambda1" {
s3_bucket                      = aws_s3_bucket.myapp.bucket
s3_key                         = aws_s3_object.uploadlambda1.key
function_name                  = "lambda1"
role                           = aws_iam_role.lambda_role.arn
handler                        = "lambda_function.lambda_handler"
runtime                        = "python3.9"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "lambda2" {
s3_bucket                      = aws_s3_bucket.myapp.bucket
s3_key                         = aws_s3_object.uploadlambda2.key
function_name                  = "lambda2"
role                           = aws_iam_role.lambda_role.arn
handler                        = "lambda_function.lambda_handler"
runtime                        = "python3.9"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}