# ----------------------------------------------------------
# Resource provisioning in Multiple AWS Regions and Account
# ----------------------------------------------------------

provider "aws" {
  region = "us-east-1"
  alias  = "us"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "ca"
}

provider "aws" {
  region = "eu-central-1"
}

//asume role to a different account
# asume_role {
#   role_arn = "arn:aws:iam::01234567890:role/role_in_account_b"
# }

resource "aws_instance" "my_us_server" {
  provider      = aws.us
  ami           = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  tags = {
    Name = "us Server"
  }
}

resource "aws_instance" "my_ca_server" {
  provider      = aws.ca
  ami           = data.aws_ami.ca_latest_amzn_linux.id
  instance_type = "t2.micro"
  tags = {
    Name = "canada Server"
  }
}

resource "aws_instance" "my_default_server" {
  ami           = "ami-070b208e993b59cea"
  instance_type = "t2.micro"
  tags = {
    Name = "Default Server"
  }
}

# ----------------------------------------------------------
data "aws_ami" "us_latest_amzn_linux" {
  provider    = aws.us
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

data "aws_ami" "ca_latest_amzn_linux" {
  provider    = aws.ca
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

data "aws_ami" "def_latest_amzn_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}
# ----------------------------------------------------------

output "us_linux_ami_id" {
  value = data.aws_ami.us_latest_amzn_linux.id
}

output "ca_linux_ami_id" {
  value = data.aws_ami.ca_latest_amzn_linux.id
}

output "def_linux_ami_id" {
  value = data.aws_ami.def_latest_amzn_linux.id
}
