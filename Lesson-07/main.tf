provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver_sg.id]
  depends_on             = [aws_instance.my_db_server]
}

resource "aws_instance" "my_app_server" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver_sg.id]
  depends_on             = [aws_instance.my_webserver]
}

resource "aws_instance" "my_db_server" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver_sg.id]
}

resource "aws_security_group" "my_webserver_sg" {
  name = "WebServer Security Group"

  dynamic "ingress" {
    for_each = ["80, 443, 8080"]
  }

  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
