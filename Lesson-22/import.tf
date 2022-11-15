# ----------------------------------------------------------
# Terraform imports
#
# Example: import aws_instance resource:
#   1 Find instance_id e.g i-0b84bc5f76fc2a8f0
#   2 Create blank resource e.g "aws_instance" "my_ec2"
#   3 Run terraform init command
#   4 Run terraform inport aws_instance.my_ec2 i-0b84bc5f76fc2a8f0
#   5 Run terraform apply
#   6 Fill in missing required fields
#   7 Run terraform apply again
# Note: be sure to run terraform plan and make appropriate changes,
# to avoid destruction of your resources.
# ----------------------------------------------------------

resource "aws_instance" "my_ec2" {

}
