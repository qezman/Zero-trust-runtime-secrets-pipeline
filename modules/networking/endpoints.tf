# VPC Endpoints for Core AWS Services
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.ztsp-vpc-endpoints-sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.project}-${var.environment}-secretsmanager-vpc-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.ztsp-vpc-endpoints-sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.project}-${var.environment}-ssm-vpc-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.ztsp-vpc-endpoints-sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.project}-${var.environment}-ssmmessages-vpc-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.ztsp-vpc-endpoints-sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.project}-${var.environment}-ec2messages-vpc-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private[*].id

  tags = {
    Name        = "${var.project}-${var.environment}-s3-vpc-endpoint"
    Environment = var.environment
  }
}
