 terraform {
   backend "s3" {
     bucket         = "terraform-state-xking"
     key            = "global/s3/terraform.tfstate"
     region         = "us-east-1"  
     dynamodb_table = "terraform-state-xking-locks"
     encrypt        = true
   }
 }

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "myapp" {
    bucket = "xking-myapp" 
}
resource "aws_s3_bucket_website_configuration" "myapp" {
  bucket = aws_s3_bucket.myapp.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
resource "aws_s3_bucket_acl" "myapp" {
  bucket = aws_s3_bucket.myapp.bucket

  acl = "public-read"
}
resource "aws_s3_bucket_policy" "myapp" {
  bucket = aws_s3_bucket.myapp.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.myapp.arn,
          "${aws_s3_bucket.myapp.arn}/*",
        ]
      },
    ]
   }
  )
}


 resource "aws_s3_object" "uploadhtml" {
   for_each = fileset("/home/racosta/repos/challenge7/website/", "*.html")
   bucket = aws_s3_bucket.myapp.id
   key    = each.value
   source = "/home/racosta/repos/challenge7/website/${each.value}"
   content_type = "text/html"
   etag = filemd5("/home/racosta/repos/challenge7/website/${each.value}")# }
 }

resource "aws_s3_object" "uploadcss" {
   for_each = fileset("/home/racosta/repos/challenge7/website/", "*.css")
   bucket = aws_s3_bucket.myapp.id
   key    = each.value
   source = "/home/racosta/repos/challenge7/website/${each.value}"
   content_type = "text/css"
   etag = filemd5("/home/racosta/repos/challenge7/website/${each.value}")
 }

resource "aws_s3_object" "uploadlambda1" {
   bucket = aws_s3_bucket.myapp.id
   key    = "lambda/lambda1"
   source = "/home/racosta/repos/challenge7/website/lambda1.zip"
   content_type = "application/zip"
   etag = filemd5("/home/racosta/repos/challenge7/website/lambda1.zip")
 }

 resource "aws_s3_object" "uploadlambda2" {
   bucket = aws_s3_bucket.myapp.id
   key    = "lambda/lambda2"
   source = "/home/racosta/repos/challenge7/website/lambda2.zip"
   content_type = "application/zip"
   etag = filemd5("/home/racosta/repos/challenge7/website/lambda2.zip")
 }


