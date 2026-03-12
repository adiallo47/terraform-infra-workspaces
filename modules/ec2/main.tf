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

data "aws_directory_service_directory" "selected_directory" {
  directory_id = var.directory_id
}

resource "aws_instance" "ssm_ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = var.vpc_security_group_ids
  # [ module.vpc.vpcworkspace_id, module.vpc.test_subnet ]
  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = "SSM-Workspace-Instance"
  }
}