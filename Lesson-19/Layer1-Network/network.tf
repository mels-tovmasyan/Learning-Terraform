provider "aws" {
  region = "eu-central-1"
}

//choose s3 bucket to save your remote state file
terraform {
  backend "s3" {
    bucket = "tfmremote"                     // bucket name
    key    = "dev/network/terraform.tfstate" // "path"
    region = "eu-central-1"                  // region of bucket
  }
}


data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "${var.env} - vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.env} - igw"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    gateway_id = aws_internet_gateway.main.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    "Name" = "${var.env}-public-subnet"
  }
}

resource "aws_route_table_association" "public_subnets" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

