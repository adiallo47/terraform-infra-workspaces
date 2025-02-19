terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_ssm_association" "execute_create_user" {
  name = aws_ssm_document.create_workspaces_user.name
  instance_id = var.ec2_instance_id 

  parameters = {
    "commands" = "powershell.exe -Command \"& {New-Item -Path C:\\Temp -ItemType Directory}\"\npowershell.exe -File C:\\create_user.ps1"
  }
  
}

resource "aws_ssm_document" "create_workspaces_user" {
  name          = "CreateWorkSpacesUser"
  document_type = "Command"

  lifecycle { create_before_destroy = true }

  content = <<EOT
{
  "schemaVersion": "1.2",
  "description": "Create a WorkSpaces user in AWS Simple AD",
  "parameters": {
    "commands": {
      "type": "StringList",
      "description": "List of PowerShell commands to execute"
    }
  },
  "runtimeConfig": {
    "aws:runPowerShellScript": {
      "properties": [
        {
          "id": "0.aws:runPowerShellScript",
          "runCommand": "{{ commands }}"
        }
      ]
    }
  }
}
EOT
}
