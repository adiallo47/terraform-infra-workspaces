output "iam_role_name"{ 
    value = aws_iam_role.workspaces_role.name
}

output "iam_role_arn"{
    value = aws_iam_role.workspaces_role.arn
}

output "iam_policy_arn"{
    value = aws_iam_policy.workspaces_policy.arn
}

output "instance_profile"{
    value = aws_iam_instance_profile.ssm_instance_profile.name
}
