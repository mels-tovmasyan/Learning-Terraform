variable "region" {
  description = "Enter desired AWS region to deploy Server"
  type        = string
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of inbound ports to open for Server"
  type        = list(any)
  default     = ["80", "443", "22", "8080"]
}

variable "enable_detailed_monitoring" {
  description = "Do you want to enable detailed monitoring?"
  type        = bool
  default     = "true"
}

variable "common_tags" {
  description = "Type your Common Tags here to apply to all resources"
  type        = map(any)
  default = {
    "Owner"      = "Mels"
    "Project"    = "Unicorn"
    "CostCenter" = "12345"
    "Env"        = "Dev"
  }
}
