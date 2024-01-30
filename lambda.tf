resource "aws_lambda_function" "main_pre_sign_up" {
  filename      = var.pre_sign_up_loc
  function_name = "${var.stage_name}_pre_sign_up"
  role          = aws_iam_role.lambda_cognito_hook.arn
  handler       = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.pre_sign_up_loc)

  runtime = "nodejs16.x"
}

resource "aws_lambda_permission" "main_pre_sign_up_permission" {
  statement_id  = "CognitoPreSignup-${var.stage_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main_pre_sign_up.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.cognito_main.arn
}
