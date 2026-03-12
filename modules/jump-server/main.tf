provider "aws" {
  region = var.region
}

resource "aws_instance" "jump_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet[0]
  key_name               = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "jump-server"
  }
}