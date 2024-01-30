provider "aws" {
  region = var.provider_region
}


resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.dev_vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Dev VPC"
  }
}

resource "aws_internet_gateway" "Internet_Gateway" {
  vpc_id = var.dev_vpc_id

  tags = {
    Name = "Dev Internet Gateway"
  }

}

resource "aws_internet_gateway_attachment" "igw-attachment" {
  vpc_id              = var.dev_vpc_id
  internet_gateway_id = aws_internet_gateway.Internet_Gateway.id
}

resource "aws_subnet" "Public_Subnet_AZ1" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.Public_Subnet_AZ1_cidr_block
  availability_zone = var.availability_zone_az1

  tags = {
    Name = "Public Subnet AZ1"
  }
}

resource "aws_subnet" "Public_Subnet_AZ2" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.Public_Subnet_AZ2_cidr_block
  availability_zone = var.availability_zone_az2

  tags = {
    Name = "Public Subnet AZ2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.dev_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }

}

resource "aws_route_table_association" "Public_Subnet_AZ1_route_table_Association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.Public_Subnet_AZ1.id
}

resource "aws_route_table_association" "Public_Subnet_AZ2_route_table_Association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.Public_Subnet_AZ2.id
}

resource "aws_subnet" "private_app_subnet_AZ1" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.private_app_subnet_az1_cidr_block
  availability_zone = var.availability_zone_az1

  tags = {
    Name = "private app subnet AZ1"
  }
}

resource "aws_subnet" "private_app_subnet_AZ2" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.private_app_subnet_az2_cidr_block
  availability_zone = var.availability_zone_az2

  tags = {
    Name = "private app subnet AZ2"
  }
}

resource "aws_subnet" "private_data_subnet_AZ1" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.private_data_subnet_az1_cidr_block
  availability_zone = var.availability_zone_az1

  tags = {
    Name = "private data subnet AZ1"
  }
}

resource "aws_subnet" "private_data_subnet_AZ2" {
  vpc_id            = var.dev_vpc_id
  cidr_block        = var.private_data_subnet_az2_cidr_block
  availability_zone = var.availability_zone_az2

  tags = {
    Name = "private data subnet AZ2"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az1 
# terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gateway_az1" {
  domain = "vpc"

  tags = {
    Name = "nat gateway az1 eip"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az2
# terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gateway_az2" {
  domain = "vpc"

  tags = {
    Name = "nat gateway az2 eip"
  }
}



resource "aws_nat_gateway" "public_nat_gateway_AZ1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = aws_subnet.Public_Subnet_AZ1.id

  tags = {
    Name = "nat gateway az1"
  }
}

resource "aws_nat_gateway" "public_nat_gateway_AZ2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = aws_subnet.Public_Subnet_AZ2.id

  tags = {
    Name = "nat gateway az2"
  }
}
