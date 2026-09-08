# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# Private subnet
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  # ensure resouces are not reachable from internet
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-${var.availability_zones[count.index]}"
  }
}

# Route Table for private subnet
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "${var.project}-${var.environment}-private-rt-${var.availability_zones[count.index]}"
  }
}

# Route table association (private subnet)
resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}



resource "aws_db_subnet_group" "private" {
  name       = "${var.project}-${var.environment}-db_subnet_group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "${var.project}-${var.environment}-db-subnet-group"
  }
}
