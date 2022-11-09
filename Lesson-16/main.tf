# ----------------------------------------------------------
# Conditions in Terraform
#
# In general conditions in Terraform look like this:
# X = CONDITION == ? VALUE_IF_TRUE : VALUE_IF_FALSE
# ----------------------------------------------------------


provider "aws" {}

// If environment is prod than t3.micro will be deployed,
// if anything else than t2.micro
resource "aws_instance" "my_webserver1" {
  ami           = "ami-070b208e993b59cea"
  instance_type = var.env == "prod" ? "t3.micro" : "t2.micro"

  tags = {
    "Name"  = "${var.env}-server"
    "Owner" = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}


// Deploy an instance only if you are in dev environment
resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-070b208e993b59cea"
  instance_type = "t2.micro"

  tags = {
    Name = "Dev Bastion Server"
  }
}


# ----------------------------------------------------------
# Lookups in Terraform
# 
# X = lookup(condition, "value")
# ----------------------------------------------------------


// Deploy an instance depending on your environment
resource "aws_instance" "my_webserver2" {
  ami           = "ami-070b208e993b59cea"
  instance_type = lookup(var.ec2_size, "prod")
}


output "my_webserver2_instance_type" {
  value = aws_instance.my_webserver2.instance_type
}

resource "aws_security_group" "webserver_sg" {
  name = "WebServer Security Group"

  // Allow ports depending on enivronment(variable "allow_ports")
  dynamic "ingress" {
    for_each = lookup(var.allow_ports, "dev")

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
}
