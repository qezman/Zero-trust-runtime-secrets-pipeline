output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.private.name
}

output "ec2_security_group_id" {
  value = aws_security_group.ztsp-ec2-sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.ztsp-rds-sg.id
}

output "vpc_endpoints_security_group_id" {
  value = aws_security_group.ztsp-vpc-endpoints-sg.id
}
