#############################################################################
# VARIABLES
#############################################################################

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "database_subnets" {
  type    = list(string)
  default = ["10.0.8.0/24", "10.0.9.0/24"]
}

variable "peering_users" {
  type = list(string)
}

variable "vpc_cidr_range_sec" {
  type = string
}

variable "public_subnets_sec" {
  type = list(string)
}

variable "private_subnets_sec" {
  type = list(string)
}

variable "intra_subnets_sec" {
  type        = list(string)
  description = "The same as private subnets but without Internet routing even if NAT Gateway is configured"
}
