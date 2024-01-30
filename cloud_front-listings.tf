# listing app
resource "aws_cloudfront_distribution" "listing_app" {
  origin {
    domain_name = aws_s3_bucket.listing_app.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.listing_app.id

    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_main.id
  }

  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_200"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.listing_app.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 400
    response_code         = 400
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
  }

  tags = {
    Environment = "listing-${var.stage_name}"
  }

  aliases = [var.LISTING_URL]

  viewer_certificate {
    acm_certificate_arn = var.ACM_CERT_ARN
    ssl_support_method  = "sni-only"
  }
}


