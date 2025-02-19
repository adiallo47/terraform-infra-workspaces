resource "aws_iam_role" "workspaces_role" {
  name = "WorkSpacesRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "workspaces.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "workspaces_policy" {
  name        = "WorkSpacesPolicy"
  description = "Allow WorkSpaces to interact with VPC, Security Groups, Directory Service, and Secrets Manager, Workspaces API"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:ModifyNetworkInterfaceAttribute",
          "ec2:DescribeRouteTables"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ds:DescribeDirectories",
          "ds:GetDirectoryLimits",
          "ds:CreateComputer",
          "ds:CreateDirectory",
          "ds:AuthorizeApplication",
          "ds:UnauthorizeApplication",
          "ds:RegisterEventTopic",
          "ds:CreateUser",
          "ds:ListUsers"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "workspaces:CreateWorkspaces",
          "workspaces:DescribeWorkspaces",
          "workspaces:DescribeWorkspaceBundles",
          "workspaces:DescribeWorkspaceDirectories",
          "workspaces:DescribeWorkspaceImages",
          "workspaces:DescribeWorkspaceSnapshots",
          "workspaces:ModifyWorkspaceProperties",
          "workspaces:ModifyWorkspaceState",
          "workspaces:RebootWorkspaces",
          "workspaces:RebuildWorkspaces",
          "workspaces:RestoreWorkspace",
          "workspaces:StartWorkspaces",
          "workspaces:StopWorkspaces",
          "workspaces:TerminateWorkspaces",
          "workspaces:ListAvailableManagementCidrRanges"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:us-east-1:123456789012:secret:my-secret-*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:ListCommandInvocations",
          "ssm:ListCommands",
          "ssm:ListTagsForResource"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "ssm:DocumentName" = "AWS-RunPowerShellScript"
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ssm:DescribeInstanceInformation",
          "ssm:ListInstanceAssociations",
          "ssm:GetDocument"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "ssm.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "ssm_ec2_role" {
  name = "SSMEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ssm_ec2_policy" {
  name        = "SSMEC2Policy"
  description = "Allow EC2 to run SSM commands and access Directory Service"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:CreateDocument",
          "ssm:DeleteDocument",
          "ssm:GetDocument",
          "ssm:UpdateDocument",
          "ssm:DescribeDocument",
          "ssm:ListDocuments"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "workspaces_role_policy_attach" {
  role = aws_iam_role.workspaces_role.name
  policy_arn = aws_iam_policy.workspaces_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_ec2_policy_attach" {
  role       = aws_iam_role.ssm_ec2_role.name
  policy_arn = aws_iam_policy.ssm_ec2_policy.arn
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "SSMInstanceProfile"
  role = aws_iam_role.ssm_ec2_role.name
}