#############################################################################
# DATA SOURCES
#############################################################################

data "aws_availability_zones" "azs_dev" {
  provider = aws.infra
}

data "aws_availability_zones" "azs_sec" {
  provider = aws.sec
}

#############################################################################
# RESOURCES
#############################################################################

# Create VPC in dev account

module "vpc_dev" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "dev-vpc"
  cidr = var.vpc_cidr_range

  azs            = slice(data.aws_availability_zones.azs_dev.names, 0, 2)
  public_subnets = var.public_subnets

  # Database subnets
  database_subnets = var.database_subnets
  database_subnet_group_tags = {
    subnet_type = "database"
  }

  providers = {
    aws = aws.infra
  }

  tags = {
    Environment = "dev"
    Team        = "infra"
  }

}

# Create VPC in sec account

module "vpc_sec" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14"

  name = "sec-vpc"
  cidr = var.vpc_cidr_range_sec

  azs             = slice(data.aws_availability_zones.azs_sec.names, 0, 2)
  public_subnets  = var.public_subnets_sec
  private_subnets = var.private_subnets_sec
  intra_subnets   = var.intra_subnets_sec

  providers = {
    aws = aws.sec
  }

  tags = {
    Environment = "all"
    Team        = "security"
  }

}
