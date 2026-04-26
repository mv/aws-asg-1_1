# vscode-modelines
# vim: set ft=terraform:

data "aws_subnets" "priv" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
#   values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.subnet_priv_tag}*"]
  }

}

#utput "data_subnets_priv_all" { value = data.aws_subnets.priv }

output "data_subnets_priv" {
  value = {
    tomap = {
      "vpc_id"   = data.aws_vpc.vpc.id
      "ids"      = data.aws_subnets.priv.ids
      "region"   = data.aws_subnets.priv.region
    }
  }
}
