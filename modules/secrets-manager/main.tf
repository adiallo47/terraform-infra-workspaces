# resource "aws_secretsmanager_secret" "user_password" {
#   name = "workspaces-user-${var.environment}-password"
# }

# resource "aws_secretsmanager_secret_version" "user_password_value" {
#   secret_id     = aws_secretsmanager_secret.user_password.id
#   secret_string = var.password
# }

