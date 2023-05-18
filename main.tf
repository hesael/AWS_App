module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}
module "network" {
  source                       = "./modules/network"
  project_name                 = var.project_name
  environment                  = var.environment
  vpc_id                       = module.vpc.vpc_id
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}
module "ec2" {
  source                     = "./modules/ec2"
  vpc_id                     = module.vpc.vpc_id
  environment                = var.environment
  public_subnet_az1_id       = module.network.public_subnet_az1_id
  private_app_subnet_az1_id  = module.network.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.network.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.network.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.network.private_data_subnet_az2_id
}
module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  db_admin    = var.db_admin
  db_pass     = var.db_pass
}

