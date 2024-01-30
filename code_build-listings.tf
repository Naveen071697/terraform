# Code Build listing app
resource "aws_codebuild_project" "listing_app_main_cb" {
  name          = "pa_listing_app_${var.stage_name}"
  description   = "Public Listing Application ${var.stage_name} Code Build"
  build_timeout = "30"

  service_role = aws_iam_role.cb_main_iam_role.arn

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false

    environment_variable {
      name  = "REACT_APP_BACKEND_API"
      value = "https://${var.api_url}/listing/"
    }

    environment_variable {
      name  = "REACT_APP_MAP_BOX_KEY"
      value = "pk.eyJ1IjoicHJvcGdvdG9tYXBzIiwiYSI6ImNsZWdvd3Z6MjBudWczcXR0cDR0ZWpxeWsifQ.1Gy6DVQUAzDmINC3P_KiUg"
    }

    environment_variable {
      name  = "REACT_APP_COGNITO_IDENTITY_POOL_ID"
      value = aws_cognito_identity_pool.cognito_id_pool_main.id
    }

    environment_variable {
      name  = "REACT_APP_COGNITO_REGION"
      value = "eu-west-1"
    }

    environment_variable {
      name  = "REACT_APP_COGNITO_USER_POOL_ID"
      value = aws_cognito_user_pool.cognito_main.id
    }

    environment_variable {
      name  = "REACT_APP_COGNITO_USER_POOL_WEB_CLIENT_ID"
      value = aws_cognito_user_pool_client.cognito_client_main.id
    }

    environment_variable {
      name  = "REACT_APP_COGNITO_DOMAIN"
      value = "https://${var.cognito_domain}.${var.aws_region}.amazoncognito.com"
    }

    environment_variable {
      name  = "REACT_APP_MAP_BOX_STYLE"
      value = var.MAP_BOX_STYLE
    }

    environment_variable {
      name  = "REACT_APP_GOOGLE_MAP_KEY"
      value = "AIzaSyC1djjqNS2RDzmsA5Ryf2wgoH6_dse-DjA"
    }

  }

  artifacts {
    encryption_disabled    = false
    name                   = "pa-listing-${var.stage_name}"
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  source {
    buildspec           = "version: 0.2\n\n#env:\n  #variables:\n     # key: \"value\"\n     # key: \"value\"\n  #parameter-store:\n     # key: \"value\"\n     # key: \"value\"\n  #secrets-manager:\n     # key: secret-id:json-key:version-stage:version-id\n     # key: secret-id:json-key:version-stage:version-id\n  #exported-variables:\n     # - variable\n     # - variable\n  #git-credential-helper: yes\n#batch:\n  #fast-fail: true\n  #build-list:\n  #build-matrix:\n  #build-graph:\nphases:\n  install:\n    #If you use the Ubuntu standard image 2.0 or later, you must specify runtime-versions.\n    #If you specify runtime-versions and use an image other than Ubuntu standard image 2.0, the build fails.\n    #runtime-versions:\n      # name: version\n      # name: version\n    commands:\n      - npm install --force\n      # - command\n  #pre_build:\n    #commands:\n      # - command\n      # - command\n  build:\n    commands:\n      - npm run build\n      # - command\n  #post_build:\n    #commands:\n      # - command\n      # - command\n#reports:\n  #report-name-or-arn:\n    #files:\n      # - location\n      # - location\n    #base-directory: location\n    #discard-paths: yes\n    #file-format: JunitXml | CucumberJson\nartifacts:\n  files:\n    - '**/*'\n    # - location\n  #name: $(date +%Y-%m-%d)\n  discard-paths: no\n  base-directory: build\n#cache:\n  #paths:\n    # - paths"
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }

  tags = {
    Environment = "listing_app-${var.stage_name}"
  }
}

