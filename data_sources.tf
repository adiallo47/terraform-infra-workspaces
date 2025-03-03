data "local_file" "users" {
  filename = "${path.module}/users.json"
}

locals {
  users = jsondecode(data.local_file.users.content).users
}
