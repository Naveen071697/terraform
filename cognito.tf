# Cognito
resource "aws_cognito_user_pool" "cognito_main" {
  name                       = "pa-listing-${var.stage_name}"
  mfa_configuration          = "OPTIONAL"
  sms_authentication_message = null

  auto_verified_attributes = [
    "email",
    "phone_number"
  ]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  email_configuration {
    configuration_set      = ""
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = ""
    reply_to_email_address = ""
    source_arn             = ""
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  sms_configuration {
    external_id    = var.sms_role_ext_id
    sns_caller_arn = aws_iam_role.cognito_main.arn
  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  lambda_config {
    pre_sign_up = aws_lambda_function.main_pre_sign_up.arn
  }

}

# Cognito Client
resource "aws_cognito_user_pool_client" "cognito_client_main" {
  name                   = "pa-${var.stage_name}"
  user_pool_id           = aws_cognito_user_pool.cognito_main.id
  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 30
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["email", "openid", "phone"]
  callback_urls                        = ["https://${aws_cloudfront_distribution.listing_app.domain_name}/login"]
  explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  prevent_user_existence_errors        = "LEGACY"
  read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo"
  ]
  supported_identity_providers = ["COGNITO"]
  write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo"
  ]
}

# Cognito Domain
resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.cognito_domain
  user_pool_id = aws_cognito_user_pool.cognito_main.id
}


resource "aws_cognito_identity_pool" "cognito_id_pool_main" {
  identity_pool_name               = "pa-${var.stage_name}"
  allow_unauthenticated_identities = false
  # allow_classic_flow               = false



  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.cognito_client_main.id
    provider_name           = aws_cognito_user_pool.cognito_main.endpoint
    server_side_token_check = true
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "cognito_id_pool_attach_main" {
  identity_pool_id = aws_cognito_identity_pool.cognito_id_pool_main.id

  roles = {
    authenticated   = "arn:aws:iam::${var.aws_acc_no}:role/Cognito_PAAuth_Role"
    unauthenticated = "arn:aws:iam::${var.aws_acc_no}:role/Cognito_PAUnauth_Role"
  }
}
