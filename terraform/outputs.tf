output "s3_bucket_website_endpoint" {
    value = aws_s3_bucket_website_configuration.bucket_config.website_endpoint
}

output "api_gateway_invoke_url" {
    value = aws_apigatewayv2_stage.lambda_api_stage.invoke_url
}

output "cloudfront_link" {
    value = aws_cloudfront_distribution.prod_distribution.domain_name
}

