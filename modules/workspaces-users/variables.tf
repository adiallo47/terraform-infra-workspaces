variable "region" {
  type = string
  description = "AWS region"
}

variable bundle_id {
  type = string
  description = "SSM bundle ID"
}

variable "directory_id" {}

variable "users" {
  type = list(object({
    username   = string
    first_name = string
    last_name  = string
    email      = string
  }))
  default = [{
      username  = "test-user"
      first_name = "Test"
      last_name = "User"
      email = "test.user@example.com"
    }
  ]
}