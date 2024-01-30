
# S3

# listing app
resource "aws_s3_bucket" "listing_app" {
  bucket = "pa-listing-${var.stage_name}"
  tags = {
    Name = "${var.product_name}-listing-${var.stage_name}"
  }
}

resource "aws_s3_bucket_acl" "listing_app_acl" {
  bucket = aws_s3_bucket.listing_app.bucket
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.listing_s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "listing_s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.listing_app.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "listing_app" {
  bucket = aws_s3_bucket.listing_app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "listing_app_policy" {
  bucket = aws_s3_bucket.listing_app.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": [
        "${aws_s3_bucket.listing_app.arn}/*"
      ],
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::${var.aws_acc_no}:distribution/${aws_cloudfront_distribution.listing_app.id}"
        }
      }
    }
  ]
}
EOF
}

# Code Commit (listing app Code Pipeline)
resource "aws_s3_bucket" "listing_app_cp" {
  bucket = "cp-listing-app-${var.stage_name}"

  tags = {
    Name = "cp-listing_app-${var.stage_name}"
  }
}

resource "aws_s3_bucket_acl" "listing_cp_bucket_acl" {
  bucket = aws_s3_bucket.listing_app_cp.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.cp_listing_s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "cp_listing_s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.listing_app_cp.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "listing_app_cp" {
  bucket = aws_s3_bucket.listing_app_cp.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
