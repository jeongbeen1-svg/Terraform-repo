resource "aws_vpc" "this" {
  cidr_block = local.vpc.cidr_block
  enable_dns_support   = local.vpc.enable_dns_support
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  
  tags = {
    Name = "${local.namespace}-vpc-${local.vpc.name}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${local.namespace}-igw"
  }
}

#pulic-a
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_public[0].cidr_block
  availability_zone       = local.subnet_public[0].availability_zone
  map_public_ip_on_launch = local.subnet_public[0].map_public_ip_on_launch

  tags = {
    Name = "${local.namespace}-subnet-${local.subnet_public[0].name}"
  }
}

resource "aws_route_table" "public_0" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${local.namespace}-rtb-${local.subnet_public[0].name}"
  }
}

resource "aws_route_table_association" "public_0" {
  subnet_id = aws_subnet.public_0.id
  route_table_id = aws_route_table.public_0.id
}


#public-b
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_public[1].cidr_block
  availability_zone       = local.subnet_public[1].availability_zone
  map_public_ip_on_launch = local.subnet_public[1].map_public_ip_on_launch

  tags = {
    Name = "${local.namespace}-subnet-${local.subnet_public[1].name}"
  }
}

resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${local.namespace}-rtb-${local.subnet_public[1].name}"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}