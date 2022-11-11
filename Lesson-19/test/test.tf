provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "tfmremote"                      // bucket name
    key    = "test/servers/terraform.tfstate" // "path"
    region = "eu-central-1"                   // region of bucket
  }
}

data "terraform_remote_state" "servers" {
  backend = "s3"
  config = {
    bucket = "tfmremote"
    key    = "dev/servers/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfmremote"                     // bucket name
    key    = "dev/network/terraform.tfstate" // "path"
    region = "eu-central-1"                  // region of bucket
  }
}

data "aws_ami" "latest_linux_eu" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

resource "aws_instance" "secured_server" {
  ami                    = data.aws_ami.latest_linux_eu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.terraform_remote_state.servers.outputs.webserver_sg]
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
}


output "aws_instance_secured_server" {
  value = aws_instance.secured_server.id
}
