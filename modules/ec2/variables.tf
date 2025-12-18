variable "directory_id" {
    description = "value of directory id"
    type = string
}

variable "region" {
    description = "value of region"
    type = string
}

variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
}

variable "ami"{
    description = "ami"
    type = string
}

variable "iam_instance_profile" {
    type = string
}

variable "subnet_ids" {
    description = "list of subnets for Directory Service"
    type = list(string)
}

variable "vpc_security_group_ids" {
    type = list(string)
}