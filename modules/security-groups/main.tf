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

resource "aws_security_group" "workspaces_sg" {
  vpc_id = var.workspace_vpc # vpc

  tags = {
    Name        = "WorkSpaces-Security-Group-${var.environment}"
    environment = var.environment
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id        = aws_security_group.workspaces_sg.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = length(data.aws_security_group.existing_bastion_sg.id) > 0 ? data.aws_security_group.existing_bastion_sg.id : aws_security_group.bastion_sg[0].id
}
#aws_security_group.bastion_sg[0].id 


# allow PCoIP (AWS WorkSpaces streaming)
resource "aws_security_group_rule" "allow_pcoip_tcp" {
  security_group_id = aws_security_group.workspaces_sg.id
  type              = "ingress"
  from_port         = 4172
  to_port           = 4172
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_pcoip_udp" {
  security_group_id = aws_security_group.workspaces_sg.id
  type              = "ingress"
  from_port         = 4172
  to_port           = 4172
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# allow WSP 
resource "aws_security_group_rule" "allow_wsp" {
  security_group_id = aws_security_group.workspaces_sg.id
  type              = "ingress"
  from_port         = 4195
  to_port           = 4195
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# allow internet access
resource "aws_security_group_rule" "allow_outbound" {
  security_group_id = aws_security_group.workspaces_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "bastion_sg" {
  count  = length(data.aws_security_group.existing_bastion_sg.id) > 0 ? 0 : 1
  name   = "bastion_sg"
  vpc_id = var.workspace_vpc

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jump-server-security-group"
  }
}

data "aws_security_group" "existing_bastion_sg" {
  filter {
    name   = "group-name"
    values = ["bastion_sg"]
  }
}
