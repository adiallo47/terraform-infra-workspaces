terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_directory_service_directory" "workspaces_directory" {
  name = var.directory_name
  password = data.aws_secretsmanager_secret_version.user_password_value.secret_string 
  size = "Small"
  type = "SimpleAD"
  #directory_id = var.directory_id

  vpc_settings {
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids
  }

  tags = {
    Name = "WorkSpaces-Directory"
    Environment = var.environment
  }
  
  # lifecycle {
  #   prevent_destroy = true
  # }
  
}

resource "aws_workspaces_ip_group" "my_ip_group" {
  name = var.ip_group_name
  description = "Allow only certain computers"
  rules {
    source = var.ip_address
    description = "test-device"
  }
}

resource "aws_workspaces_directory" "my_directory" {
  directory_id = var.directory_id
  ip_group_ids = [aws_workspaces_ip_group.my_ip_group.id]
}

data "aws_secretsmanager_secret" "user_password" {
  name = "workspaces-user-password" #secret exists in AWS Secrets Manager
}

data "aws_secretsmanager_secret_version" "user_password_value" {
  secret_id = data.aws_secretsmanager_secret.user_password.id
}