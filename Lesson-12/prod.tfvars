region                     = "eu-central-1"
instance_type              = "t3.micro"
enable_detailed_monitoring = true

allow_ports = ["80"]

common_tags = {
  "Owner"      = "Mels"
  "Project"    = "Unicorn"
  "CostCenter" = "12345"
  "Env"        = "Prod"
}
