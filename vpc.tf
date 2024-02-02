#vpc
resource "aws_vpc" "main" {
  cidr_block = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

#public subnet
resource "aws_subnet" "public" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "public-sub-${count.index + 1}"
  }
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#public route table
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub-rt"
  }
}

#association
resource "aws_route_table_association" "rt-assoc" {
  count = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.pub-route.id
}

#private subnet
resource "aws_subnet" "private" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 8, count.index + 2)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "private-sub-${count.index + 1}"
  }
}

#eip
resource "aws_eip" "eip-ngw" {
  count  = length(aws_subnet.private)
  domain = "vpc"

  tags = {
    Name = "eip-${count.index + 1}"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "ngw" {
  count             = length(aws_subnet.private)
  allocation_id     = aws_eip.eip-ngw[count.index].id
  connectivity_type = "public"
  subnet_id         = element(aws_subnet.public[*].id, count.index)
}
  
#Route table private #  
resource "aws_route_table" "route_table_private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "priv_rt_${count.index + 1}"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
  }
}

#Route table association private
resource "aws_route_table_association" "assoc_priv_subs" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}

