# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.stage_name}-igw"
  }

  depends_on = [aws_vpc.main_vpc]
}
