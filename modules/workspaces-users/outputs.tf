output "user_name" {
  value = var.users
}

output "ssm_document_name" {
  value = aws_ssm_document.create_workspaces_user.name
}
