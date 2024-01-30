# # Authorizer
# resource "aws_api_gateway_authorizer" "api_gateway_auth_main" {
#   name          = "${var.stage_name}_authorizer"
#   rest_api_id   = aws_api_gateway_rest_api.api_gateway_main.id
#   type          = "COGNITO_USER_POOLS"
#   provider_arns = [aws_cognito_user_pool.cognito_main.arn]
# }
