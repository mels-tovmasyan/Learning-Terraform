# ----------------------------------------------------------
# Resource provisioning in Multiple AWS Regions and Account
# ----------------------------------------------------------

provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}


provider "aws" {
  region = "ca-central-1"
  alias  = "CA"
}


provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_us_server" {
  provider      = aws.USA
  ami           = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  tags = {
    Name = "USA Server"
  }
}


data "aws_ami" "ca_lates_amzn_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

resource "aws_instance" "my_ca_server" {
  provider      = aws.CA
  ami           = data.aws_ami.ca_lates_amzn_linux.id
  instance_type = "t2.micro"
  tags = {
    Name = "Canada Server"
  }
}

resource "aws_instance" "my_default_server" {
  ami           = "ami-070b208e993b59cea"
  instance_type = "t2.micro"
  tags = {
    Name = "Default Server"
  }
}



output "latest_linux_ami_id" {
  value = data.aws_ami.ca_lates_amzn_linux.id
}
