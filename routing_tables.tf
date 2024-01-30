
# Routing table creation for Public route 1
resource "aws_route_table" "main_rtb_public_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.stage_name}-rtb-public-1"
  }

  depends_on = [aws_vpc.main_vpc, aws_internet_gateway.main_igw]
}

# Routing table public subnet association 1
resource "aws_route_table_association" "main_rta_public_1" {
  subnet_id      = aws_subnet.sg_public_1.id
  route_table_id = aws_route_table.main_rtb_public_1.id

  depends_on = [aws_subnet.sg_public_1, aws_route_table.main_rtb_public_1]
}

# Routing table creation for Public 2 route
resource "aws_route_table" "main_rtb_public_2" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.stage_name}-rtb-public-2"
  }

  depends_on = [aws_vpc.main_vpc, aws_internet_gateway.main_igw]
}

# Routing table public subnet association
resource "aws_route_table_association" "main_rta_public_2" {
  subnet_id      = aws_subnet.sg_public_2.id
  route_table_id = aws_route_table.main_rtb_public_2.id

  depends_on = [aws_subnet.sg_public_2, aws_route_table.main_rtb_public_2]
}

# Routing table creation for Private route
resource "aws_route_table" "main_rtb_private_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat.id
  }

  tags = {
    Name = "${var.stage_name}-rtb-private-1"
  }

  depends_on = [aws_vpc.main_vpc]
}

# Routing table private subnet association
resource "aws_route_table_association" "main_rta_private_1" {
  subnet_id      = aws_subnet.sg_private_1.id
  route_table_id = aws_route_table.main_rtb_private_1.id

  depends_on = [aws_subnet.sg_private_1, aws_route_table.main_rtb_private_1]
}

# Routing table creation for Private route
resource "aws_route_table" "main_rtb_private_2" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat.id
  }

  tags = {
    Name = "${var.stage_name}-rtb-private-2"
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_route_table_association" "main_rta_private_2" {
  subnet_id      = aws_subnet.sg_private_2.id
  route_table_id = aws_route_table.main_rtb_private_2.id

  depends_on = [aws_subnet.sg_private_2, aws_route_table.main_rtb_private_2]
}
