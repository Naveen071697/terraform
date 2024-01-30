resource "aws_iam_instance_profile" "ec2_role" {
  name = "listing-aws-elasticbeanstalk-ec2-role-${var.stage_name}"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name = "listing-aws-elasticbeanstalk-ec2-role-${var.stage_name}"

  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier", "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker", "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"]

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "service_role" {
  name = "listing-aws-elasticbeanstalk-service-role-${var.stage_name}"
  role = aws_iam_role.service_role.name
}

resource "aws_iam_role" "service_role" {
  name = "listing-aws-elasticbeanstalk-service-role-${var.stage_name}"

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth", "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"]

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "elasticbeanstalk.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "elasticbeanstalk"
                }
            }
        }
    ]
}
EOF
}
