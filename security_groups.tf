
# Private Security Group
resource "aws_security_group" "main_sg_private" {
  name        = "sg_private-${var.stage_name}"
  description = "Private Security Group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "Private"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_private-${var.stage_name}"
  }

  depends_on = [aws_vpc.main_vpc]
}

# Public Security Group
resource "aws_security_group" "main_sg_public" {
  name        = "sg_public-${var.stage_name}"
  description = "Public Security Group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "Anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_public-${var.stage_name}"
  }

  depends_on = [aws_vpc.main_vpc]
}

# DB Security Group
resource "aws_security_group" "main_sg_db_private" {
  name        = "sg_private-db-${var.stage_name}"
  description = "DB Private Security Group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "DB"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = var.db_port
    to_port          = var.db_port
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-private-db-${var.stage_name}"
  }

  depends_on = [aws_vpc.main_vpc]
}
