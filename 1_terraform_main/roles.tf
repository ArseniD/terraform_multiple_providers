#############################################################################
# DATA SOURCES
#############################################################################

data "aws_caller_identity" "infra" {
  provider = aws.infra
}

data "aws_caller_identity" "sec" {
  provider = aws.sec
}

#############################################################################
# RESOURCES
#############################################################################

# Create a role that can be assumed by the AWS infra account

resource "aws_iam_role" "peer_role" {
  name     = "peer_role"
  provider = aws.sec

  # Create the assume_role_policy to allow another AWS account (infra) to assume (take) this role
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.infra.account_id}:root"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  }
  EOF
}

# Create a policy to allow peering acceptance and attach it to the IAM role

resource "aws_iam_role_policy" "peering_policy" {
  name     = "vpc_peering_policy"
  role     = aws_iam_role.peer_role.id
  provider = aws.sec

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:AcceptVpcPeeringConnection",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:CreateTags"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF

}

# Create a group that can accept peering connections

resource "aws_iam_group" "peering" {

  name     = "VPCPeering"
  provider = aws.infra

}

# Add members to the group

resource "aws_iam_group_membership" "peering-members" {
  name     = "VPCPeeringMembers"
  provider = aws.infra

  users = var.peering_users
  group = aws_iam_group.peering.name

}

# Create a group policy that can assume the peering role in the security account

resource "aws_iam_group_policy" "peering-policy" {
  name     = "peering-policy"
  group    = aws_iam_group.peering.id
  provider = aws.infra

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "${aws_iam_role.peer_role.arn}"
      }
    ]
  }
  EOF

}
