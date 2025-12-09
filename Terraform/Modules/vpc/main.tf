# Generate VPC
resource "aws_vpc" "memos-vpc" {
  tags = {
    Name = "memos-vpc"
    cidr_block = var.vpc_CIDR
    enable_dns_hostnames = true
    enable_dns_support   = true
  }
}

# Generate Public subnet a
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.public_subnet_a_az
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_subnet_a"
  }
}

# Generate Public subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.public_subnet_b_az

  tags = {
    Name = "Public_subnet_B"
  }
}

# Generate Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # Public route to the internet via the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Generate Internet Gateway
resource "aws_internet_gateway" "igw-memos" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-memos"
  }
}

# Associate the public subnets with the route tables
resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public.id
}


