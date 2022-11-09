variable "env" {
  description = "Choose environment to deploy my_webserver1"
  // default = ""
}
# play with env variable and use terraform plan to see what you get.

variable "prod_owner" {
  default = "Mels Tovmasyan"
}

variable "noprod_owner" {
  default = "John Smith"
}

variable "ec2_size" {
  default = {
    "prod"    = "t3.micro"
    "dev"     = "t2.small"
    "staging" = "t2.micro"
  }
}

variable "allow_ports" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "22", "8080"]
  }
}
