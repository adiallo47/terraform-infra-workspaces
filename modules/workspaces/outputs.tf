output "workspaces_production_id" {
  value = [for ws in aws_workspaces_workspace.prod_workspaces : ws.workspace_id]
  #aws_workspaces_workspace.prod_workspaces[*].id
}

output "workspaces_testing_id" {
  value = aws_workspaces_workspace.testing_workspaces[*].id
}
    