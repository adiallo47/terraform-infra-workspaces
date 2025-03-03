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

variable "directory_id" {}
variable "users" {
  type = list(object({
    username   = string
    first_name = string
    last_name  = string
    email      = string
  }))
  default = []
}
resource "aws_workspaces_workspace" "new_user" {
  for_each = { for user in var.users : user.username => user }
  directory_id = var.directory_id
  user_name    = each.key
  bundle_id    = var.bundle_id
}