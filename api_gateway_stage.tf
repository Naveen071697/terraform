
resource "aws_api_gateway_stage" "api_gateway_stg_main" {
  deployment_id = aws_api_gateway_deployment.api_gateway_depl.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_main.id
  stage_name    = var.stage_name
  variables = {
    listing_api_url    = "${aws_lb.nlb_listing_backend.dns_name}"
  }
}
