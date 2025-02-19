output "user_name" {
  value = var.user_name
}

output "ssm_document_name" {
  value = aws_ssm_document.create_workspaces_user.name
}
