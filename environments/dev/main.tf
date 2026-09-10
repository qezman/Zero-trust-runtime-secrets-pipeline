module "networking" {
  source = "../../modules/networking"

  project              = var.project
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  region               = var.region
}

module "database" {
  source = "../../modules/database"

  project           = var.project
  environment       = var.environment
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  db_name           = var.db_name
  username          = var.username

  db_subnet_group_name   = module.networking.db_subnet_group
  vpc_security_group_ids = [module.networking.rds_security_group_id]
}

module "iam" {
  source = "../../modules/iam"

  project     = var.project
  environment = var.environment
  secret_arn  = module.database.master_user_secret_arn
}
