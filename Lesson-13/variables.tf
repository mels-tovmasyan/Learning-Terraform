variable "owner" {
  default = "Mels"
}

variable "environment" {
  default = "Dev"
}

variable "project_name" {
  default = "Unicorn"
}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.project_name}'s PO - ${var.owner}"
}

locals {
  az_list = join(",", data.aws_availability_zones.available.names)
}
