provider "aws" {
}

resource "aws_instance" "my_Amazon_Linux" {
  count         = 0
  ami           = "ami-070b208e993b59cea"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Mels"
    Project = "Terraform"
  }
}
