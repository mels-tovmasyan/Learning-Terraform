# ----------------------------------------------------------
# Local Variables
# ----------------------------------------------------------

provider "aws" {}

resource "aws_eip" "my_static_ip" {
  tags = {
    "Name"    = "Static IP"
    "Owner"   = var.owner
    "Project" = local.full_project_name
    "Po"      = local.project_owner
    "AZs"     = local.az_list
  }
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}


output "az_list" {
  value = local.az_list
}
