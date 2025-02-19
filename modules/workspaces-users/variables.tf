variable "region" {
  type = string
  description = "AWS region"
}

variable "directory_id" {
  type = string
  description = "AWS Simple AD directory name"
}

variable "user_name" {
  type = string
  description = "Username to be created"
}

variable "user_password" {
  type = string
  description = "Password for the user"
  sensitive = true
}

variable "ec2_instance_id" {
  type = string
  description = "EC2 instance ID to execute SSM commands"
}
