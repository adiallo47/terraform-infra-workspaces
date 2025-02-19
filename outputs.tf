output "directory_id" {
  value = module.directory_service.directory_id
}

# output "admin_password" {
#   value = module.directory_service.admin_password
#   sensitive = true
# }

output "workspaces_production" {
  value = module.workspaces_production
}

output "workspaces_testing" {
  value = module.workspaces_testing
}
