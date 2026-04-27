# vscode-modelines
# vim: set ft=terraform:

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }
}

#utput "data_vpc" { value = data.terraform_remote_state.vpc.outputs.vpc_id }
output "data_vpc" {
  value = {
    tomap = {
      "vpc_id"          = data.terraform_remote_state.vpc.outputs.vpc_id
      "public_subnets"  = data.terraform_remote_state.vpc.outputs.public_subnets
      "private_subnets" = data.terraform_remote_state.vpc.outputs.public_subnets
    }
  }
}

