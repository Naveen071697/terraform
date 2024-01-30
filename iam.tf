# Code Pipeline role
resource "aws_iam_role" "cp_main_iam_role" {
  name = "code_pipeline_iam_role-listing-${var.stage_name}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "codepipeline.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}


# Code Build role
resource "aws_iam_role" "cb_main_iam_role" {
  name = "code_build_iam_role-listing-${var.stage_name}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "codebuild.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF

  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]

  tags = {
    Name = "code_build_iam_role-${var.stage_name}"
  }
}


# Cognito
resource "aws_iam_role" "cognito_main" {
  name = "cognito_main-listing-${var.stage_name}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "cognito-idp.amazonaws.com"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "StringEquals": {
            "sts:ExternalId": "${var.sms_role_ext_id}"
          }
        }
      }
    ]
  }
  EOF
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "main_rds" {

  name = "listing-rds-monitoring-role-${var.stage_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]

  tags = {
    Name = "listing-rds-monitoring-role-${var.stage_name}"
  }
}

# Lambda
resource "aws_iam_role" "lambda_cognito_hook" {
  name = "lambda_cognito_hook-${var.stage_name}"

  assume_role_policy = <<-EOF
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

# # Cognito
# resource "aws_iam_role" "cognito_auth_role" {
#   name               = "cognito_auth_role-${var.stage_name}"
#   assume_role_policy = <<EOF
#   {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#               "Action": "sts:AssumeRole",
#               "Principal": {
#                   "Federated": "cognito-identity.amazonaws.com"
#               },
#               "Effect": "Allow",
#               "Sid": ""
#             }
#         ]
#   }
#   EOF
# }

# resource "aws_iam_role" "cognito_unauth_role" {
#   name               = "cognito_unauth_role-${var.stage_name}"
#   assume_role_policy = <<EOF
#  {
#       "Version": "2012-10-17",
#       "Statement": [
#            {
#                 "Action": "sts:AssumeRole",
#                 "Principal": {
#                      "Federated": "cognito-identity.amazonaws.com"
#                 },
#                 "Effect": "Allow",
#                 "Sid": ""
#            }
#       ]
#  }
#  EOF
# }
