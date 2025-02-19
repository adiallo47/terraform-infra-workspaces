variable "directory_name" {
  description = "The name of the WorkSpaces Directory Service"
  type = string
  default = ""
}

variable "vpc_cidr_block_main" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "vpc_cidr_block_prod" {
  description = "The CIDR block for the production VPC"
  type = string
}

variable "vpc_cidr_block_test" {
  description = "The CIDR block for the test VPC"
  type = string
}

variable "az1" {
  description = "Availability zone 1"
  type = string
  default = ""
}

variable "az2" {
  description = "Availability zone 2"
  type = string
  default = ""
}

variable "az3" {
  description = "Availability zone 3"
  type = string
  default = ""
}

variable "user_name" {
  description = "list of user names for Directory Service"
  type = string
  default = ""
}

# variable "user_name_prod" {
#   description = "list of user names for Directory Service"
#   type = string
# }

variable "user_password" {
  description = "password for Directory Service"
  type = string
  sensitive = true
  default = ""
}

variable "bundle_id" {
  description = "bundle id for WorkSpaces"
  type = string
  default = "wsb-g5rbnq51n"
}

variable "env1" {
  description = "environment name"
  type = string
}

variable "env2" {
  description = "environment name"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type = list(string)
}

variable "directory_id" {
  description = "value of directory id"
  type = string
  default = "d-9067c727f2"
}

variable "region" {
  description = "The AWS region where resources will be created"
  type = string
}

variable "ec2_instance_id" {
  description = "value of instance id"
  type = string
}

variable "ip_group_name" {
    description = "name of the IP group"
    type = string
    default = "workspaces-IP-group"
}

variable "address" {
  description = "List of IP addresses"
  type = string
}

variable "custom_image_id" {
  description = "Custom AMI ID"
  type = string
}

variable "prod_user_name" {
  description = "Prod user name"
  type = string
}
