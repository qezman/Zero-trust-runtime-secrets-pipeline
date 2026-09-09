resource "aws_db_instance" "main" {
  identifier                  = "${var.project}-${var.environment}-db"
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  storage_encrypted           = true
  db_name                     = var.db_name
  username                    = var.username
  manage_master_user_password = true
  db_subnet_group_name        = var.db_subnet_group_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  multi_az                    = true
  publicly_accessible         = false
  skip_final_snapshot         = true
  deletion_protection         = false
  apply_immediately           = true
}
