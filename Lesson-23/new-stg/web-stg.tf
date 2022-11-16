resource "aws_instance" "web-Stg" {
  ami                    = data.aws_ami.latest_amz_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-stg.id]
  user_data              = <<EOF
#!/bin/bash
yum update -y
yum install httpd.x86_64 -y
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World, from $(hostname -f)" > /var/www/html/index.html
EOF

  tags = {
    "Name"  = "stg-webserver"
    "Owner" = "Mels Tovmasyan"
  }
}
resource "aws_security_group" "web-stg" {
  name        = "WebServer-SG-stg"
  description = "Staging SG for WebServer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"  = "Staging SG for WebServer"
    "Owner" = "Mels Tovmasyan"
  }
}
