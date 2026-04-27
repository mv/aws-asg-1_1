/*****/
locals {
# ingress = {
#   http_8080 = { from = 8080, to=8080 , protocol = "tcp", cidr = "0.0.0.0/0" }
# }
}


##
## My SG
##
module "sg" {
  source = "../../../../modules/security-group"

  name        = join("", ["asg-", replace(local.name, "asg-", "")] )
  description = "ASG: [${local.name}] security group"

  vpc_id  = local.vpc_id
# ingress = local.ingress
# egress  = local.egress

  tags = {
    "env" = "dev"
    "app" = "asg"
  }
}