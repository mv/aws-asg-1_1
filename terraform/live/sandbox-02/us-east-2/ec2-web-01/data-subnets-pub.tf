# vscode-modelines
# vim: set ft=terraform:

data "aws_subnets" "pub" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
#   values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.subnet_pub_tag}*"]
  }

}

output "data_subnets_pub" {
  value = {
    tomap = {
      "vpc_id"   = data.aws_vpc.vpc.id
      "ids"      = data.aws_subnets.pub.ids
      "region"   = data.aws_subnets.pub.region
    }
  }
}
