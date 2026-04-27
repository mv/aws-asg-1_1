/*****/
locals {
# vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress = {
    http_8080 = { from = 8080, to=8080 , protocol = "tcp", cidr = "0.0.0.0/0" }
  }
}


##
## My SG
##
module "sg" {
  source = "../../../../modules/security-group"

# name        = join("", ["nlb-", replace(local.name, "nlb-", "")] )
  name        = local.name
  description = "NLB: [${local.name}] security group"

  vpc_id  = local.vpc_id
  ingress = local.ingress
# egress  = local.egress

  tags = {
    "env" = "dev"
    "app" = "asg"
  }
}