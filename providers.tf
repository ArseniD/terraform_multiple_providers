terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  alias   = "infra"
  profile = "infra"
}

provider "aws" {
  region  = var.region
  alias   = "sec"
  profile = "sec"
}
