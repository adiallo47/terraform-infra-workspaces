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

resource "aws_workspaces_workspace" "new_user" {
  for_each = { for user in var.users : user.username => user if user.username != "" }
  directory_id = var.directory_id
  user_name    = each.value.username
  bundle_id    = var.bundle_id
}