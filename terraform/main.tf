provider "aws" {
    
    region = "us-east-1"  
}

resource "aws_s3_bucket" "frontend_bucket" {
    bucket = var.s3_bucket_name
    policy = file("policy.json")
    force_destroy = true

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

resource "aws_s3_bucket_acl" "frontend_bucket" {
    bucket = aws_s3_bucket.frontend_bucket.id
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "bucket_config" {
    bucket = aws_s3_bucket.frontend_bucket.id
    index_document {
        suffix = "index.html"
    }
}