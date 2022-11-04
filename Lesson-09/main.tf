# ---------------------------------------------------------
# Find most recent Amazon Linux 2, 
# launch an instance using it
# and print ami.id and ami.name
# ---------------------------------------------------------

provider "aws" {
  region = "ca-central-1"
}

data "aws_ami" "latest_amz_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}

resource "aws_instance" "fresh_webserver" {
  ami           = data.aws_ami.latest_amz_linux.id
  instance_type = "t2.micro"
}

output "latest_amz_linux_ami_id" {
  value = data.aws_ami.latest_amz_linux.id
}

output "latest_amz_linux_ami_name" {
  value = data.aws_ami.latest_amz_linux.name
}
