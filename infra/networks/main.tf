resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = var.elastic_ip_name
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
  }
  depends_on = [aws_vpc.vpc]
}

//resource "aws_nat_gateway" "custom_ngw" {
//  allocation_id = aws_eip.eip.id
//  subnet_id     = aws_subnet.public_subnet.id
//  depends_on    = [aws_eip.eip, aws_subnet.public_subnet]
//}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = var.public_route_table_name
  }

  depends_on = [aws_vpc.vpc, aws_internet_gateway.internet_gateway]
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
  depends_on     = [aws_route_table.public_route_table, aws_subnet.public_subnet]
}