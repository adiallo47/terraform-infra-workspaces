variable "workspace_vpc" {
  description = "VPC ID where the security group will be created"
  type = string
}

variable "environment" {
  description = "environment name"
  type = string
}

variable region {
    type = string
    description = "the AWS region where resources will be created"
}