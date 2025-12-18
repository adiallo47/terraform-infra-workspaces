variable "region" {
    description = "AWS region"
    type = string
}

variable "ami" {
  description = "AMI ID for the jump server"
  type = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  description = "EC2 instance type for the jump server"
  type = string
  default = "t3.micro"
}

variable "security_group_id" {
  description = "ID of the security group for the jump server"
  type = string
}

variable "public_subnet" {}
variable "key_pair_name" {}