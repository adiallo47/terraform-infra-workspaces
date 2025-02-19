output "directory_id" {
    value = aws_directory_service_directory.workspaces_directory.id                        
}

output "admin_password_secret_arn" {
  value = data.aws_secretsmanager_secret.user_password.arn
  sensitive = true
}

output "ip_group_id" {
  value = aws_workspaces_ip_group.my_ip_group.id
}