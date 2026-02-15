#Resource : vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge(var.tags, {Name = "${var.environment_name}-vpc"})
}

# Resource : Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {Name = "${var.environment_name}-igw"})
}

# Resource : Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  for_each = {for idx, az in local.azs: az => local.public_subnet[idx]}
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags, {Name = "${var.environment_name}-public-${each.key}"})
}

#Resource : Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  for_each = {for idx, az in local.azs: az => local.private_subnet[idx]}
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags, {Name = "${var.environment_name}-private-${each.key}"})
}

#Resource : Elastic IP for Nat Gateway
resource "aws_eip" "nat" {
  tags = merge(var.tags, {Name = "${var.environment_name}-nat-eip"})
}

#Resource : Nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = values(aws_subnet.public_subnet)[0].id
  tags = merge(var.tags, {Name = "${var.environment_name}-nat-eip"})
  depends_on = [ aws_internet_gateway.igw ]
}

#Resource : Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, {Name = "${var.environment_name}-public_rt"})
}

#Resource : public route table associate to public subnet
resource "aws_route_table_association" "public_rt_associate" {
  for_each = aws_subnet.public_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

#Resource : Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, {Name = "${var.environment_name}-private_rt"})
}

#Resource : private route table associate to private subnet
resource "aws_route_table_association" "private_rt_associate" {
  for_each = aws_subnet.private_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_rt.id
}