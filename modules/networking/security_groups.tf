resource "aws_security_group" "ztsp-ec2-sg" {
  name        = "${var.project}-${var.environment}-ec2-sg"
  description = "Security group for the EC2 server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "${var.project}-${var.environment}-ec2-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "ztsp-rds-sg" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "Security group for the postgres database"
  vpc_id      = aws_vpc.main.id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-rds-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "ztsp-vpc-endpoints-sg" {
  name        = "${var.project}-${var.environment}-vpc-endpoints-sg"
  description = "Security group for VPC Interface Endpoints"
  vpc_id      = aws_vpc.main.id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-vpc-endpoints-sg"
    Environment = var.environment
  }
}

# Cross-referencing rules, as separate resources to avoid the cycle

resource "aws_vpc_security_group_egress_rule" "ec2_to_vpc_endpoints" {
  security_group_id            = aws_security_group.ztsp-ec2-sg.id
  referenced_security_group_id = aws_security_group.ztsp-vpc-endpoints-sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  description                  = "HTTPS to VPC endpoints"
}

resource "aws_vpc_security_group_egress_rule" "ec2_to_rds" {
  security_group_id            = aws_security_group.ztsp-ec2-sg.id
  referenced_security_group_id = aws_security_group.ztsp-rds-sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "PostgreSQL to RDS"
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_ec2" {
  security_group_id            = aws_security_group.ztsp-rds-sg.id
  referenced_security_group_id = aws_security_group.ztsp-rds-sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "PostgreSQL from EC2"
}

resource "aws_vpc_security_group_ingress_rule" "endpoints_from_ec2" {
  security_group_id            = aws_security_group.ztsp-vpc-endpoints-sg.id
  referenced_security_group_id = aws_security_group.ztsp-ec2-sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  description                  = "HTTPS from EC2"
}
