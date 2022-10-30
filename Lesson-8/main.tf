provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_regions" "current" {}

output "data_aws_availability_zones" {
    value = data.aws_availability_zones.working.names #List of the Availability Zone names available to the account
}

output "data_aws_caller_identity" {
    value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
    value = data.aws_regions.current.names
}