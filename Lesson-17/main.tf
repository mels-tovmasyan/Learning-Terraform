# ----------------------------------------------------------
# Terraform join Loops: Count and For if
# ----------------------------------------------------------

// Don"t forget to pass your credentials and region
provider "aws" {}


// Create single IAM User
resource "aws_iam_user" "user1" {
  name = "denis"
}


// Create and count users from above list
resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index + 1)
}


# ----------------------------------------------------------

// name servers using index of count parameter
resource "aws_instance" "servers" {
  count         = 4
  ami           = "ami-070b208e993b59cea"
  instance_type = "t2.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

