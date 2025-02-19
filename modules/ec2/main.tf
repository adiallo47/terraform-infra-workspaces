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
  ami = "ami-04b4f1a9cf54c11d0" # unbuntu
  instance_type = "t2.micro"
  subnet_id  = [ module.vpc.vpcworkspace_id, module.vpc.test_subnet ]
  iam_instance_profile = module.iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "SSM-Instance"
  }
}