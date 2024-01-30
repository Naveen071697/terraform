resource "aws_api_gateway_vpc_link" "listing_backend_vpc_link" {
  name        = "listing_backend-${var.stage_name}"
  target_arns = [aws_lb.nlb_listing_backend.arn]
}
