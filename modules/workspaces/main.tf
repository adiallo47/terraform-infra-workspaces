terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_workspaces_workspace" "prod_workspaces" {
    count = var.workspace_type == "production" ? 1 : 0
    directory_id = var.directory_id
    bundle_id = var.custom_image_id
    user_name = var.prod_user_name
    #module.workspaces_users.user_name

    root_volume_encryption_enabled = false
    user_volume_encryption_enabled = false
    volume_encryption_key = null
    
    workspace_properties {
        compute_type_name = "VALUE"  # Options: VALUE, STANDARD, PERFORMANCE, POWER
        root_volume_size_gib = 80
        user_volume_size_gib = 50
        running_mode = "AUTO_STOP" 
        running_mode_auto_stop_timeout_in_minutes = 60
    }
    tags = {
        Name = "ubuntu workspaces-production"
        environmet = "production"
    }
}

resource "aws_workspaces_workspace" "testing_workspaces" {
  count = var.workspace_type == "testing" ? 1 : 0
  directory_id = var.directory_id
  bundle_id = var.bundle_id
  user_name = var.user_name
  #module.workspaces_users.user_name
  
  root_volume_encryption_enabled = false
  user_volume_encryption_enabled = false
  volume_encryption_key = null

  workspace_properties {
    compute_type_name = "VALUE"
    root_volume_size_gib = 80
    user_volume_size_gib = 50
    running_mode = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }
  tags = {
        Name = "ubuntu workspaces-testing"
        environmet = "testing"
    }
}