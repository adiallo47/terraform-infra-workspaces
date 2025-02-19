terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "workspaces_vpc" {
    cidr_block = var.vpc_cidr_block_main # MAIN /24 for 256 ips
    enable_dns_support = true
    enable_dns_hostnames = true

  tags = {
    Name = "workspaces-vpc-main"
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_subnet" "workspaces_subnet_prod" { # subnet1 private workspaces prod
  vpc_id = aws_vpc.workspaces_vpc.id
  cidr_block = var.vpc_cidr_block_prod # /26 for 64 ips
  availability_zone = var.az1
  map_public_ip_on_launch = false  # workspaces need private ip

  tags = {
    Name = "workspaces-subnet-prod-private"
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_subnet" "workspaces_subnet_test" { # subnet2 private only needed for testing environment
  vpc_id = aws_vpc.workspaces_vpc.id
  cidr_block = var.vpc_cidr_block_test # /28 for 16 ips
  availability_zone = var.az2
  map_public_ip_on_launch = false  

  tags = {
    Name = "workspaces-subnet-test-private"
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_subnet" "public_subnet" { # subnet3 public
  vpc_id = aws_vpc.workspaces_vpc.id
  cidr_block = var.vpc_cidr_block_public
  availability_zone = var.az3
  map_public_ip_on_launch = true

  tags = {
    Name = "workspaces-subnet-public-NAT-Gateway"
  }
}

resource "aws_internet_gateway" "workspaces_igw" { # internet gateway
  vpc_id = aws_vpc.workspaces_vpc.id

  tags = {
    Name = "public-workspaces-igw"
  }
}

resource "aws_route_table" "public_route_table" { # route table to gateway
  vpc_id = aws_vpc.workspaces_vpc.id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.workspaces_igw.id
  }

  tags = {
    Name = "public-workspaces-route-table"
  }
}

resource "aws_route_table_association" "public_association" { # public subnet to route table : internet gateway
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "prod_association" { # production subnet to private NAT
  subnet_id = aws_subnet.workspaces_subnet_prod.id 
  route_table_id = aws_route_table.private_route_table.id
}


resource "aws_route_table_association" "test_association" { # test subnet to private NAT
  subnet_id = aws_subnet.workspaces_subnet_test.id
  route_table_id = aws_route_table.private_route_table.id
}

#-PRIVATE-#

resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet.id  # public subnet
  tags = { 
    Name = "NAT gateway" 
    }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.workspaces_vpc.id

  route {
    cidr_block = var.route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.nat.id  # private subnets route through NAT
  }

  tags = { 
    Name = "private-workspaces-route table"
    }
}