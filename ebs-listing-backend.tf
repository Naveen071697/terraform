resource "aws_elastic_beanstalk_environment" "pa_listing_backend" {
  name                = "listing-backend-${var.stage_name}"
  application         = aws_elastic_beanstalk_application.pa_listing.name
  solution_stack_name = var.backend_docker_emi
  setting {
    name      = "AssociatePublicIpAddress"
    namespace = "aws:ec2:vpc"
    value     = "false"
  }
  setting {
    name      = "Automatically Terminate Unhealthy Instances"
    namespace = "aws:elasticbeanstalk:monitoring"
    value     = "true"
  }
  setting {
    name      = "Availability Zones"
    namespace = "aws:autoscaling:asg"
    value     = "Any"
  }
  setting {
    name      = "EC2KeyName"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.key_pair_name
  }
  setting {
    name      = "ELBScheme"
    namespace = "aws:ec2:vpc"
    value     = "internal"
  }
  setting {
    name      = "ELBSubnets"
    namespace = "aws:ec2:vpc"
    value     = join(",", [aws_subnet.sg_private_1.id, aws_subnet.sg_private_2.id])
  }
  setting {
    name      = "EnhancedHealthAuthEnabled"
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    value     = "true"
  }
  setting {
    name      = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "LoadBalanced"
  }

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_iam_instance_profile.ec2_role.name
  }

  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.ebs_listing_backend_instance_size
  }
  setting {
    name      = "InstanceTypeFamily"
    namespace = "aws:cloudformation:template:parameter"
    value     = "t2"
  }
  setting {
    name      = "InstanceTypes"
    namespace = "aws:ec2:instances"
    value     = var.ebs_listing_backend_instance_size
  }
  setting {
    name      = "LoadBalancerType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "application"
  }
  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    value     = "1"
  }

  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value     = "4"
  }

  setting {
    name      = "MeasureName"
    namespace = "aws:autoscaling:trigger"
    value     = "CPUUtilization"
  }

  setting {
    name      = "Unit"
    namespace = "aws:autoscaling:trigger"
    value     = "Percent"
  }

  setting {
    name      = "UpperThreshold"
    namespace = "aws:autoscaling:trigger"
    value     = "70"
  }

  setting {
    name      = "LowerThreshold"
    namespace = "aws:autoscaling:trigger"
    value     = "50"
  }

  setting {
    name      = "Period"
    namespace = "aws:autoscaling:trigger"
    value     = "5"
  }

  setting {
    name      = "BreachDuration"
    namespace = "aws:autoscaling:trigger"
    value     = "5"
  }
  setting {
    name      = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value     = aws_iam_instance_profile.service_role.name
  }
  setting {
    name      = "Subnets"
    namespace = "aws:ec2:vpc"
    value     = join(",", [aws_subnet.sg_private_1.id, aws_subnet.sg_private_2.id])
  }
  setting {
    name      = "SystemType"
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    value     = "enhanced"
  }
  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = aws_vpc.main_vpc.id
  }
  setting {
    name      = "XRayEnabled"
    namespace = "aws:elasticbeanstalk:xray"
    value     = "true"
  }
  setting {
    name      = "NODE_ENV"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = "staging"
  }

  setting {
    name      = "PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = "1998"
  }

  setting {
    name      = "DB_HOST"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = element(split(":", aws_db_instance.main_db.endpoint), 0)
  }

  setting {
    name      = "DB_NAME"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_name
  }

  setting {
    name      = "DB_USERNAME"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_username
  }

  setting {
    name      = "DB_PASSWORD"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_password
  }

  setting {
    name      = "DB_PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_port
  }

  setting {
    name      = "SYNC_URL"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.SYNC_URL
  }
  setting {
    name      = "API_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = "F9BF03B95668DFD96E360B888F0251CDAAC6AF7D0E05FE61B5B0FCB5189D09D5"
  }

  setting {
    name      = "ALERT_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU2MmEwMzNkLTQ1ZjQtNDIwOC05NmVhLTdkOWU0ZWY1ZTU3MSIsInByb2ZpbGVJZCI6ImRjOWI2N2ZmLThjODUtNGFhMC1hNTU0LWUzZTQzMWM3YThiNiIsImlhdCI6MTY0MTE5OTA4M30.cPdPBWIdgK-dsXRHVpGmu9tcl4ZgyFqNZfcDIKQfEMI"
  }

  setting {
    name      = "ALERTHUB_ENDPOINT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = "https://alertshub-api.crayond.com/api/v1/sendmessage"
  }

}
