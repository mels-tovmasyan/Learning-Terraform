provider "aws" {
  region = "eu-central-1"
}


terraform {
  backend "s3" {
    bucket = "tfmremote"
    key    = "globalvars/terraform.tfstate"
    region = "eu-central-1"
  }
}

#==========================================
output "company_name" {
  value = "Unicorn"
}

output "owner" {
  value = "Mels Tovmasyan"
}

output "tags" {
  value = {
    "Project"    = "Unicorn"
    "CostCenter" = "Commercial"
  }
}
