# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource.

  tags = merge(
    var.local-tags,
    {
      "Name" = "${var.PROJECT_NAME}-vpc-1-base",
      "Demo" = "testing"
    }
  )
}


# create public subnet public-subnet-a
resource "aws_subnet" "public-subnet-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_SUBNET_A_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-public-subnet-a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

# create public subnet public-subnet-b
resource "aws_subnet" "public-subnet-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_SUBNET_B_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-public-subnet-b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

# create public subnet public-subnet-c
resource "aws_subnet" "public-subnet-c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_SUBNET_C_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch = true

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-public-subnet-c",
      "kubernetes.io/role/elb" = 1
    }
  )
}

# create private subnet private-subnet-a
resource "aws_subnet" "private-subnet-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRIVATE_SUBNET_A_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-private-subnet-a",
      "kubernetes.io/role/internal-elb"	= 1
    }
  )
}

# create private subnet private-subnet-b
resource "aws_subnet" "private-subnet-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRIVATE_SUBNET_B_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-private-subnet-b",
      "kubernetes.io/role/internal-elb"	= 1
    }
  )
}

# create private subnet private-subnet-c
resource "aws_subnet" "private-subnet-c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRIVATE_SUBNET_C_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch = false

  tags = merge(
    var.local-tags,
    {
      Name  = "${var.PROJECT_NAME}-private-subnet-c",
      "kubernetes.io/role/internal-elb"	= 1
    }
  )
}


# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.local-tags,
    {
      "Name" = "${var.PROJECT_NAME}-igw"
    }
  )
}


# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(
    var.local-tags,
    {
      Name = "${var.PROJECT_NAME}-Public-RT"
    }
  )
}

## associate public subnet pub-sub-1-a to "public route table"
resource "aws_route_table_association" "public-subnet-a_route_table_association" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnet public-subnet-b to "public route table"
resource "aws_route_table_association" "public-subnet-b_route_table_association" {
  subnet_id      = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnet public-subnet-c to "public route table"
resource "aws_route_table_association" "public-subnet-c_route_table_association" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.public_route_table.id
}



#creating NAT Gateway
module "NAT-Gateway" {
  source         = "./nat-gateways"
  PUB_SUB_A_ID = aws_subnet.public-subnet-a.id
  PUB_SUB_B_ID = aws_subnet.public-subnet-b.id
  PUB_SUB_C_ID = aws_subnet.public-subnet-c.id
  IGW_ID =  aws_internet_gateway.internet_gateway.id
  VPC_ID = aws_vpc.vpc.id
  PRI_SUB_A_ID = aws_subnet.private-subnet-a.id
  PRI_SUB_B_ID = aws_subnet.private-subnet-b.id
  PRI_SUB_C_ID = aws_subnet.private-subnet-c.id
  local-tags= var.local-tags
}
