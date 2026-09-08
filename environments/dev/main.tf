module "networking" {
  source             = "../../modules/networking"
  project            = var.project
  environment        = var.environment
  availability_zones = var.availability_zones
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  region             = var.region
}
