resource "aws_elastic_beanstalk_application" "pa_listing" {
  name        = "pa-lising-${var.stage_name}"
  description = "pa-listing-${var.stage_name}"

  appversion_lifecycle {
    service_role          = "arn:aws:iam::${var.aws_acc_no}:role/pa_profile_role_${var.stage_name}"
    max_count             = 200
    delete_source_from_s3 = true
  }
}


