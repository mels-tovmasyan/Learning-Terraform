#----------------------------------------------------------
# My Terraform
#
# Build Simple WebServer during Bootstrap
#
# Made by Mels
#----------------------------------------------------------

provider "aws" {
}

resource "aws_eip" "my_instance_ip" {
  instance = aws_instance.my_webserver.id 
}

resource "aws_instance" "my_webserver" {
  ami = "ami-070b208e993b59cea"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
  f_name = "Mels",
  l_name = "Tovmasyan",
  names = ["Adam", "John", "Joshua", "Maria", "Annabel"]
  })

}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
