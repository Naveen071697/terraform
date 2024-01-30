# Admin app code pipeline
resource "aws_codepipeline" "listing_app_cp" {
  name     = "listing-${var.stage_name}"
  role_arn = aws_iam_role.cp_main_iam_role.arn

  artifact_store {
    location = aws_s3_bucket.listing_app_cp.bucket
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
        FullRepositoryId     = "propgoto/public_listing-app"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      namespace        = "BuildVariables"
      region           = var.aws_region
      # role_arn         = ""
      run_order = 1
      version   = "1"
      configuration = {
        ProjectName = "${aws_codebuild_project.listing_app_main_cb.name}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        BucketName = "${aws_s3_bucket.listing_app.bucket}"
        Extract    = "true"
      }
      input_artifacts  = ["BuildArtifact"]
      name             = "Deploy"
      namespace        = "DeployVariables"
      output_artifacts = []
      owner            = "AWS"
      provider         = "S3"
      region           = var.aws_region
      # role_arn         = ""
      run_order = 1
      version   = "1"
    }
  }
}
