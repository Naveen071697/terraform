# NAT Gateway for Private Subnet
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.main_eip.id
  subnet_id     = aws_subnet.sg_public_1.id

  tags = {
    Name = "${var.stage_name}_nat"
  }
}
