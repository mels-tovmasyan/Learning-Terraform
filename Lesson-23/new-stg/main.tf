data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amz_linux" {
  owners      = ["137112412989"] //amazon's id
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*"]
  }
}
