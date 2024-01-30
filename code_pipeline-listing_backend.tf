resource "aws_codepipeline" "pipeline_listing_backend_cp" {
  name     = "listing-backend-${var.stage_name}"
  role_arn = aws_iam_role.cp_main_iam_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_listing_backend_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category         = "Source"
      input_artifacts  = []
      name             = "Source"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceArtifact"]
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      region           = var.aws_region
      run_order        = 1
      version          = "1"
      configuration = {
        BranchName           = "${var.common_branch_name}"
        ConnectionArn        = "${aws_codestarconnections_connection.pa_github.arn}"
        FullRepositoryId     = "propgoto/public-listing"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        ApplicationName = aws_elastic_beanstalk_application.pa_listing.name
        EnvironmentName = aws_elastic_beanstalk_environment.pa_listing_backend.name
      }
      input_artifacts  = ["SourceArtifact"]
      name             = "Deploy"
      namespace        = "DeployVariables"
      output_artifacts = []
      owner            = "AWS"
      provider         = "ElasticBeanstalk"
      region           = var.aws_region
      role_arn         = ""
      run_order        = 1
      version          = "1"
    }
  }
}
