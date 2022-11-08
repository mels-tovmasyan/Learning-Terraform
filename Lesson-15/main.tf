# ----------------------------------------------------------
# Generate Passwords, store in SSM Parameter Store and use  
# ----------------------------------------------------------

provider "aws" {}


variable "name" {
  default = "Reset"
  # Modify default value, to change your RDS Master password to a new random one
}


resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!@#$"
  # Only these special characters are allowed
  keepers = {
    keeper1 = var.name
  }
}


resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_password.rds_password.result
}


data "aws_ssm_parameter" "my_rds_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}


resource "aws_db_instance" "mysql" {
  allocated_storage   = 10
  db_name             = "prodrds"
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  username            = "administrator"
  password            = data.aws_ssm_parameter.my_rds_password.value
  skip_final_snapshot = true
  apply_immediately   = true
}


output "rds_pawssord" {
  value = nonsensitive(data.aws_ssm_parameter.my_rds_password.value)
  # Terraform requires to add either value = sensitive,
  # to your string, 
  # or to use value = nonsensitive() format
  # Note: password will be stored as plain text in your .tfstate anyways
}
