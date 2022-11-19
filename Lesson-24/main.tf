provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "prod"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "dev"
}


module "servers" {
  source = "./module_servers"
  providers = {
    aws.root = aws
    aws.prod = aws.prod
    aws.dev  = aws.dev
  }
}
