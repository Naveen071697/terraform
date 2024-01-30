# Subnet Public Group
resource "aws_db_subnet_group" "main_subnet_public_group" {
  name       = "subnet_public_grp-listing-${var.stage_name}"
  subnet_ids = [aws_subnet.sg_public_1.id, aws_subnet.sg_public_2.id]

  tags = {
    Name = "subnet_public_grp-listing-${var.stage_name}"
  }

  depends_on = [aws_subnet.sg_public_1, aws_subnet.sg_public_2]
}

# Subnet Private Group
resource "aws_db_subnet_group" "main_subnet_private_group" {
  name       = "subnet_private_grp-listing-${var.stage_name}"
  subnet_ids = [aws_subnet.sg_private_1.id, aws_subnet.sg_private_2.id]

  tags = {
    Name = "subnet_private_grp-listing-${var.stage_name}"
  }

  depends_on = [aws_subnet.sg_private_1, aws_subnet.sg_private_2]
}
