
# Creating Public Subnet
resource "aws_subnet" "sg_public_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.stage_name}-public-1"
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "sg_public_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.stage_name}-public-2"
  }

  depends_on = [aws_vpc.main_vpc]
}

# Creating Private Subnet
resource "aws_subnet" "sg_private_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.stage_name}-private-1"
  }

  depends_on = [aws_vpc.main_vpc]
}

# Creating Private Subnet
resource "aws_subnet" "sg_private_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "${var.stage_name}-private-2"
  }

  depends_on = [aws_vpc.main_vpc]
}
