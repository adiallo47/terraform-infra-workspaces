variable "region" {
  type = string
  description = "AWS region"
}

variable "directory_id" {
  type = string
  description = "AWS Simple AD directory name"
}

variable "users" {
  type = string
  description = "Username to be created"
}

variable bundle_id {
  type = string
  description = "SSM bundle ID"
}
