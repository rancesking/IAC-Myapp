# 🔗 My serveless APP
<p align="center">
<img src="https://i.ibb.co/THcSLWK/avatar.png">
</p>
This application use HTML, CCS, JS to invoke the lambdas via the apigateway on AWS . 🦦🦦

## Challenge week 7

In this week we going to use IAC with terraform to create our infrastucture on AWS. My challenge was to deploy a serveless aplication using at least one api gateway and two lambdas. For my challenge i decide to deploy an S3 static website, this kind of service is free and you only need to upload you page in html and set all the setting on the bucket for locate the index file and error file and allow the bucket to act as website. [Static Website](http://xking-myapp.s3-website-us-east-1.amazonaws.com).

## About the project

To use this project first you need to clone the repo and then export AIM credentials on your system the variables are: AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY with this variables you have access to the AWS SDK and you can start creating the infraestructure.

1)Inicialize terraform.
```js
terraform init

```
2) Review the terraform plan
```js
terraform plan
```

3) Deploy the infraestructure
```js
terraform apply
```

The output called "Bucket_Direction" is the URL of the S3 static website.
