# ----------------------------------------------------------
# Variables in Terraform, strings, list, bool and map
# ----------------------------------------------------------

provider "aws" {
  region = var.region
}


# Find the latest Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}


resource "aws_eip" "static_ip" {
  instance = aws_instance.webserver.id
  tags     = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-Server IP" })
}


resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  monitoring             = var.enable_detailed_monitoring
  tags                   = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-WebServer" })
}


resource "aws_security_group" "webserver_sg" {
  name = "WebServer Security Group"

  dynamic "ingress" {
    for_each = var.allow_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-WebServer Security Group" })
}
