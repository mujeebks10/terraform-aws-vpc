# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-public-web-RT"
  })
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private App Route Tables
resource "aws_route_table" "private_app" {
  count  = local.nat_gateway_count
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = local.nat_gateway_count > 0 ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[count.index].id
    }
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-private-app-RT-${count.index}"
  })
}

# Private App Route Table Associations
resource "aws_route_table_association" "private_app" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = local.nat_gateway_count > 1 ? aws_route_table.private_app[count.index].id : aws_route_table.private_app[0].id
}

# Private DB Route Tables
resource "aws_route_table" "private_db" {
  count  = local.nat_gateway_count
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = local.nat_gateway_count > 0 ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[count.index].id
    }
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-private-db-RT-${count.index}"
  })
}

# Private DB Route Table Associations
resource "aws_route_table_association" "private_db" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = local.nat_gateway_count > 1 ? aws_route_table.private_db[count.index].id : aws_route_table.private_db[0].id
}

# VPC Peering Route (Optional)
resource "aws_route" "vpc_peering" {
  count = var.enable_vpc_peering ? 1 : 0

  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.peered_vpc_cidr
  vpc_peering_connection_id = var.vpc_peering_id
}