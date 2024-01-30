# Rest API
resource "aws_api_gateway_rest_api" "api_gateway_main" {

  name        = "PA ${var.stage_name} gateway - Public Listing"
  description = "PA ${var.stage_name} API Gateway Service for Public Listing"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

# API Gateway Custom Domain
resource "aws_api_gateway_domain_name" "api_gateway" {
  regional_certificate_arn = var.ACM_CERT_ARN_REGIONAL
  domain_name              = var.api_url

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "api_gateway_mapping_main" {
  api_id      = aws_api_gateway_rest_api.api_gateway_main.id
  stage_name  = aws_api_gateway_stage.api_gateway_stg_main.stage_name
  domain_name = aws_api_gateway_domain_name.api_gateway.domain_name
}

# Add the API path using the below order
# 1. Resource
# 2. Method
# 3. Integration
# 4. Method Response
# 5. Integration Response

resource "aws_api_gateway_deployment" "api_gateway_depl" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id

  triggers = {
    redeployment = sha1(
      jsonencode([

        # listing
        aws_api_gateway_resource.resource_listing.id,

        aws_api_gateway_method.method_listing_default.id,
        aws_api_gateway_integration.integration_listing_default.id,
        aws_api_gateway_method_response.method_response_listing_default.id,
        aws_api_gateway_integration_response.integration_response_listing_default.id,

        aws_api_gateway_resource.resource_listing_proxy.id,
        aws_api_gateway_method.method_listing.id,
        aws_api_gateway_integration.integration_listing.id,
        aws_api_gateway_method_response.method_response_listing.id,
        aws_api_gateway_integration_response.integration_response_listing.id,

      ]),
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}
