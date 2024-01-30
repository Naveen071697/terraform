resource "aws_api_gateway_resource" "resource_listing" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_main.root_resource_id
  path_part   = "listing"
}

# Post method for /listing
resource "aws_api_gateway_method" "method_listing_default" {
  depends_on    = [aws_api_gateway_resource.resource_listing]
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id   = aws_api_gateway_resource.resource_listing.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Post method Response for the /sample route
resource "aws_api_gateway_method_response" "method_response_listing_default" {
  depends_on  = [aws_api_gateway_integration.integration_listing_default]
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id = aws_api_gateway_resource.resource_listing.id
  http_method = aws_api_gateway_method.method_listing_default.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
  }
}

# Integration for /sample route POST method
resource "aws_api_gateway_integration" "integration_listing_default" {
  depends_on              = [aws_api_gateway_method.method_listing]
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id             = aws_api_gateway_resource.resource_listing.id
  http_method             = aws_api_gateway_method.method_listing_default.http_method
  integration_http_method = "ANY"
  type                    = "HTTP"
  uri                     = "http://${aws_elastic_beanstalk_environment.pa_listing_backend.endpoint_url}"
  passthrough_behavior    = "WHEN_NO_MATCH"

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.listing_backend_vpc_link.id
}

# Post integration Response for the /sample route
resource "aws_api_gateway_integration_response" "integration_response_listing_default" {
  depends_on  = [aws_api_gateway_integration.integration_listing]
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id = aws_api_gateway_resource.resource_listing.id
  http_method = aws_api_gateway_method.method_listing_default.http_method
  status_code = aws_api_gateway_method_response.method_response_listing_default.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

# Proxy

resource "aws_api_gateway_resource" "resource_listing_proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  parent_id   = aws_api_gateway_resource.resource_listing.id
  path_part   = "{proxy+}"
}

# Post method for /listing
resource "aws_api_gateway_method" "method_listing" {
  depends_on    = [aws_api_gateway_resource.resource_listing_proxy]
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id   = aws_api_gateway_resource.resource_listing_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

# Post method Response for the /sample route
resource "aws_api_gateway_method_response" "method_response_listing" {
  depends_on  = [aws_api_gateway_integration.integration_listing]
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id = aws_api_gateway_resource.resource_listing_proxy.id
  http_method = aws_api_gateway_method.method_listing.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# Integration for /sample route POST method
resource "aws_api_gateway_integration" "integration_listing" {
  depends_on              = [aws_api_gateway_method.method_listing]
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id             = aws_api_gateway_resource.resource_listing_proxy.id
  http_method             = aws_api_gateway_method.method_listing.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_elastic_beanstalk_environment.pa_listing_backend.endpoint_url}/{proxy}"
  passthrough_behavior    = "WHEN_NO_MATCH"

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.listing_backend_vpc_link.id

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}

# Post integration Response for the /sample route
resource "aws_api_gateway_integration_response" "integration_response_listing" {
  depends_on  = [aws_api_gateway_integration.integration_listing]
  rest_api_id = aws_api_gateway_rest_api.api_gateway_main.id
  resource_id = aws_api_gateway_resource.resource_listing_proxy.id
  http_method = aws_api_gateway_method.method_listing.http_method
  status_code = aws_api_gateway_method_response.method_response_listing.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}
