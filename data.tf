# Here we are providing existing resource information (subnet in which all eks cluster gonna create)
/*
data "aws_subnets" "available-subnets" {
  filter {
    name = "tag:Name"
    values = [ "nike-public-*" ]
  }
}
*/

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

/*
data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks.name
}
*/