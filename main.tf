terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "useast1"
}

data "aws_secretsmanager_secret" "user_password" {
  name = "workspaces-user-password"
}

data "aws_secretsmanager_secret_version" "user_password_value" {
  secret_id = data.aws_secretsmanager_secret.user_password.id
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
  # external = var.external
}

module "directory_service" {
  source = "./modules/directory-service"
  region = "us-east-1"
  vpc_id = module.vpc.vpcworkspace_id
  subnet_ids = concat(module.vpc.production_subnet, module.vpc.test_subnet)
  directory_id = module.directory_service.directory_id  
  environment = "AWS"
  user_password = data.aws_secretsmanager_secret_version.user_password_value.secret_string
  # var.user_password
  ip_group_name = var.ip_group_name
  ip_address = var.address
}

module "security_group_production" {
  source = "./modules/security-groups"
  workspace_vpc = module.vpc.vpcworkspace_id
  environment = var.env1
  region = var.region
}

module "security_group_testing" {
  source = "./modules/security-groups"
  workspace_vpc = module.vpc.vpcworkspace_id
  environment = var.env2
  region = var.region
}


module "workspaces_production" {
  source = "./modules/workspaces"
  workspace_type = "production"
  directory_id = module.directory_service.directory_id
  #var.directory_id
  bundle_id = var.bundle_id
  user_name = var.user_name
  custom_image_id = var.custom_image_id
  prod_user_name = local.users
  environment = "production"
}


module "workspaces_testing" {
  source = "./modules/workspaces"
  workspace_type = "testing"
  directory_id = module.directory_service.directory_id
  #var.directory_id
  bundle_id = var.bundle_id
  user_name = var.user_name
  environment = "testing"
}

module "iam" {
  source = "./modules/iam"
  region = var.region
}

module "workspaces_users" {
  source = "./modules/workspaces-users"
  region = var.region
  directory_id = module.directory_service.directory_id
  users = local.users
  bundle_id = var.bundle_id
}