
# S3

# listing backend
resource "aws_s3_bucket" "pipeline_listing_backend_bucket" {
  bucket = "cp-pa-listing-backend-${var.stage_name}"
  tags = {
    Name = "cp-listing_backend-${var.stage_name}"
  }
}

resource "aws_s3_bucket_acl" "pipeline_listing_backend_bucket_acl" {
  bucket = aws_s3_bucket.pipeline_listing_backend_bucket.bucket
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.listing_backend_s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "listing_backend_s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.pipeline_listing_backend_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "pipeline_listing_backend_bucket" {
  bucket = aws_s3_bucket.pipeline_listing_backend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "pipeline_listing_backend_bucket_policy" {
  bucket = aws_s3_bucket.pipeline_listing_backend_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCodePipelineServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": [
        "${aws_s3_bucket.pipeline_listing_backend_bucket.arn}/*"
      ],
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:codepipeline::${var.aws_acc_no}:distribution/${aws_codepipeline.pipeline_listing_backend_cp.id}"
        }
      }
    }
  ]
}
EOF
}
