provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "tfmremote"                     // bucket name
    key    = "dev/servers/terraform.tfstate" // "path"
    region = "eu-central-1"                  // region of bucket
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

resource "aws_security_group" "webserver_sg" {
  name   = "WebServer Security Group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"  = "webserver_sg"
    "Owner" = "Mels"
  }
}
