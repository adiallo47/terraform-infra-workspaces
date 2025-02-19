variable region {
    type = string
    description = "the AWS region where resources will be created"
}

variable az1 {
    default = "us-east-1c"
    type = string
    description = "the AWS region where resources will be created"
}
  
variable az2 {
    default = "us-east-1b"
    type = string
    description = "the AWS region where resources will be created"
}

variable az3 {
    default = "us-east-1a"
    type = string
    description = "the AWS region where resources will be created"
}

variable vpc_cidr_block_main {
    default = "10.0.0.0/24"
    type = string
    description = "the CIDR block for the VPC"
}

variable vpc_cidr_block_prod {
    default = "10.0.0.192/26"
    type = string
    description = "the CIDR block for the VPC"
}

variable vpc_cidr_block_test {
    default = "10.0.0.64/28" # 16 IPs collected
    type = string
    description = "the CIDR block for the VPC test"
}
variable vpc_cidr_block_public {
    default = "10.0.0.128/26"
    type = string
    description = "the CIDR block for the VPC private"
}

variable route_table_cidr_block {
    default = "0.0.0.0/0" #open internet access
    type = string
    description = "the CIDR block for the route table"
}

# variable "external" {
#     type = string
#     description = "external"
# }