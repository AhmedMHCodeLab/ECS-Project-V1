locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security-groups"
  
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  tags         = local.common_tags
}

# ECR Module
module "ecr" {
  source = "./modules/ecr"
  
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

# Application Load Balancer Module
module "alb" {
  source = "./modules/alb"
  
  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id
  domain_name         = var.domain_name
  create_certificate  = var.create_certificate
  tags                = local.common_tags
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"
  
  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  ecs_security_group_id  = module.security_groups.ecs_security_group_id
  target_group_arn       = module.alb.target_group_arn
  container_image        = var.container_image
  tags                   = local.common_tags
}