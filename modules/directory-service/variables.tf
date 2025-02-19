variable "vpc_id" {
  description = "VPC ID where Directory Service will be deployed"
  type = string
}

variable "subnet_ids" {
  description = "list of subnets for Directory Service"
  type = list(string)
}

variable "directory_name" {
  description = "domain name for Directory Service"
  type = string
  default = "Dous-Directory-WorkSpaces.local"
}

variable "directory_id" {
  description = "id for Directory Service"
  type = string
}

variable "environment" {
  description = "Environment type"
  type = string
}

variable "user_password" {
  description = "password for Directory Service"
  type = string
  sensitive = true
}

variable region {
    type = string
    description = "the AWS region where resources will be created"
}

variable "ip_group_name" {
    description = "name of the IP group"
    type = string
    default = "workspaces-IP-group"
}

variable "ip_address" {
    description = "IP addresses to be added to the IP group"
    type = string
}