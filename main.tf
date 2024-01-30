# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


# Code Pipeline connector (GitHub)
resource "aws_codestarconnections_connection" "pa_github" {
  name          = "pa-github-${var.stage_name}"
  provider_type = "GitHub"
}

# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "cloudfront_main" {
  name                              = "cf-origin-access-listing-${var.stage_name}"
  description                       = "cf-origin-access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
