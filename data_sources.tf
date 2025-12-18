data "local_file" "users" {
  #filename = file("/Users/amadoudiallo/ideaprojects/workspace-deployment/ansible-config/group_vars/users.yml")
  filename = "/Users/amadoudiallo/ideaprojects/workspace-deployment/terraform-infrastructure/users.json"
}

locals {
  users = jsondecode(data.local_file.users.content).users
}
