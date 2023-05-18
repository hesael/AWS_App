
### network module main.tf ###

#######################################################################################
# Internet Gateway Configuration
#######################################################################################

# internet gateway build attached to the VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

#######################################################################################
# Elastic IPs 
#######################################################################################

# This eip will be used for the nat-gateway in the public subnet az1 
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc = true

  tags = {
    Name = "nat gateway az1 eip"
  }
}

# This eip will be used for the nat-gateway in the public subnet az2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc = true

  tags = {
    Name = "nat gateway az2 eip"
  }
}

#######################################################################################
# Public Subnets Configuration in az1 and az2
#######################################################################################

# Getting all availability zones in the region via datasource
data "aws_availability_zones" "available_zones" {}

# public subnet creation in Availability Zone 1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-public-az1"
  }
}

# public subnet build in in Availability Zone 2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-public-az2"
  }
}

#######################################################################################
# Routing Table Configuration for Public Subnets in az1 and az2
#######################################################################################

# route table and public route build
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}
# public subnet az1 association to public route table
resource "aws_route_table_association" "public_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id 
  route_table_id = aws_route_table.public_route_table.id 
}

# public subnet az2 association to public route table
resource "aws_route_table_association" "public_subnet_2_rt_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id 
  route_table_id = aws_route_table.public_route_table.id 
}

#######################################################################################
# Private Subnets Configuration in az1 an az2. 1 per AZ for App Servers, 1 for DB Servers
#######################################################################################

 # az1 private subnet for App Servers
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_app_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names [0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-az1"
  }
}

# az2 private subnet for App Servers
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_app_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names [1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-az2"
  }
}

# az1 private subnet for Database Servers
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_data_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-data-az1"
  }
}

# az2 private subnet for Database Servers
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_data_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-data-az2"
  }
}
#######################################################################################
# NAT Gateway Configuration for az1 and az2
#######################################################################################

# nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "nat gateway az1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc
  depends_on = [aws_internet_gateway.internet_gateway]
}

# nat gateway in public subnet az2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id

  tags = {
    Name = "nat gateway az2"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc
  depends_on = [aws_internet_gateway.internet_gateway]
}

#######################################################################################
# Routing Table Configuration for Private Subnets in az1 and az2
#######################################################################################

# private route table az1 route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id 
  }

  tags = {
    Name = "private route table az1"
  }
}

# associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_rt_az1_association" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id 
  route_table_id = aws_route_table.private_route_table_az1.id
}

# associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_data_subnet_az1_rt_az1_association" {
  subnet_id      = aws_subnet.private_data_subnet_az1.id 
  route_table_id = aws_route_table.private_route_table_az1.id
}

# private route table az1 route through nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }

  tags = {
    Name = "private route table az2"
  }
}

# associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_rt_az2_association" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id 
  route_table_id = aws_route_table.private_route_table_az2.id
}

# associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_rt_az2_association" {
  subnet_id      = aws_subnet.private_data_subnet_az2.id 
  route_table_id = aws_route_table.private_route_table_az2.id
}

