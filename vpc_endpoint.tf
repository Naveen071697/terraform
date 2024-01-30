# resource "aws_vpc_endpoint" "main_vpce" {
#   vpc_id          = aws_vpc.main_vpc.id
#   service_name    = "com.amazonaws.${var.aws_region}.s3"
#   route_table_ids = [aws_route_table.main_rtb_private_1.id, aws_route_table.main_rtb_private_2.id]

#   tags = {
#     Environment = "${var.stage_name}-vpce"
#   }
# }
