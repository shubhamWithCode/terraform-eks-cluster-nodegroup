# Here we are providing existing resource information (subnet in which all eks cluster gonna create)

data "aws_subnets" "available-subnets" {
  filter {
    name = "tag:Name"
    values = [ "nike-public-*" ]
  }
}