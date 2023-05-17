provider "aws" {
    
    region = "us-east-1"  
}

resource "aws_s3_bucket" "frontend_bucket" {
    bucket = "cloud-resume-challenge-frontend-bucket-001"
    force_destroy = true
    acl = "public-read"
}

resource "aws_s3_bucket_policy" "allow_public_access" {
    bucket = aws_s3_bucket.frontend_bucket.id
    
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::cloud-resume-challenge-frontend-bucket-001/*"
            ]
        }
    ]
}
POLICY
}


resource "aws_s3_bucket_cors_configuration" "frontend_bucket_cors" {
    bucket = aws_s3_bucket.frontend_bucket.id

    cors_rule {
      allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    }

    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_config" {
    bucket = aws_s3_bucket.frontend_bucket.id
    index_document {
        suffix = "index.html"
    }
}