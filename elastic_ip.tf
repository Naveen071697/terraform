# Creating Elastic IP
resource "aws_eip" "main_eip" {
  vpc = true

  tags = {
    Name = "${var.stage_name}_eip"
  }

  depends_on = [aws_internet_gateway.main_igw]
}
