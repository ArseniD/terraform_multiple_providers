#############################################################################
# OUTPUTS
#############################################################################

output "dev_account_id" {
  value = data.aws_caller_identity.infra.account_id
}

output "dev_database_subnet_group" {
  value = module.vpc_dev.database_subnet_group
}
output "dev_peer_group_users" {
  value = aws_iam_group_membership.peering-members.users
}

output "dev_subnets_database" {
  value = module.vpc_dev.database_subnets
}

output "dev_subnets_intra" {
  value = module.vpc_dev.intra_subnets
}

output "dev_subnets_private" {
  value = module.vpc_dev.private_subnets
}

output "dev_subnets_public" {
  value = module.vpc_dev.public_subnets
}

output "dev_vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "sec_account_id" {
  value = data.aws_caller_identity.sec.account_id
}

output "sec_peer_role_arn" {
  value = aws_iam_role.peer_role.arn
}

output "sec_subnets_database" {
  value = module.vpc_sec.database_subnets
}

output "sec_subnets_intra" {
  value = module.vpc_sec.intra_subnets
}

output "sec_subnets_private" {
  value = module.vpc_sec.private_subnets
}

output "sec_subnets_public" {
  value = module.vpc_sec.public_subnets
}

output "sec_vpc_id" {
  value = module.vpc_sec.vpc_id
}
