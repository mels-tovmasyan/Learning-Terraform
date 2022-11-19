terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.root,
        aws.prod,
        aws.dev
      ]
    }
  }
}


data "aws_ami" "latest_amz_linux_root" {
  provider    = aws.root
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

data "aws_ami" "latest_amz_linux_prod" {
  provider    = aws.prod
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

data "aws_ami" "latest_amz_linux_dev" {
  provider    = aws.dev
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}


resource "aws_instance" "server_root" {
  provider      = aws.root
  ami           = data.aws_ami.latest_amz_linux_root.id
  instance_type = var.instance_type
  tags          = { "Name" = "Server-Root" }
}

resource "aws_instance" "server_prod" {
  provider      = aws.prod
  ami           = data.aws_ami.latest_amz_linux_prod.id
  instance_type = var.instance_type
  tags          = { "Name" = "Server-Prod" }
}

resource "aws_instance" "server_dev" {
  provider      = aws.dev
  ami           = data.aws_ami.latest_amz_linux_dev.id
  instance_type = var.instance_type
  tags          = { "Name" = "Server-Dev" }
}
