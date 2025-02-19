variable "bundle_id" {
    description = "bundle id for WorkSpaces" 
    type = string
}

variable "user_name" {
    description = "user names for WorkSpaces"
    type = string
}

variable "prod_user_name" {
    description = "user names for WorkSpaces prod"
    type = string
    default = ""
}

variable "custom_image_id" {
    description = "custom image id for WorkSpaces"
    type = string
    default = ""
}

variable "directory_id" {
    description = "directory id for WorkSpaces"
    type = string
}

variable "environment" {
    description = "environment name"
    type = string
}

variable "workspace_type" {
  type = string
  description = "Type of workspace to create (production or testing)"
}