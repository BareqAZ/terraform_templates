resource "aws_vpc" "main" {
  cidr_block           = "10.128.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = var.name
    owner = var.owner
  }
}

resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.128.1.0/24"
  map_public_ip_on_launch = true


  tags = {
    Name  = var.name
    owner = var.owner
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name  = var.name
    owner = var.owner
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name  = var.name
    owner = var.owner
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}

resource "aws_security_group" "default" {
  name   = var.name
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = var.name
    owner = var.owner
  }
}
