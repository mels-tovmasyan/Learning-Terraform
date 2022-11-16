provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "tfmremote"
    key    = "new-prd/terraform.tfstate"
    region = "eu-central-1"
  }
}
