# vscode-modelines
# vim: set ft=terraform:

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }
}

output "data_vpc_all" { value = data.terraform_remote_state.vpc.outputs        }
output "data_vpc_id"  { value = data.terraform_remote_state.vpc.outputs.vpc_id }
output "data_vpc" {
  value = {
      "vpc_id"          = data.terraform_remote_state.vpc.outputs.vpc_id
      "public_subnets"  = data.terraform_remote_state.vpc.outputs.public_subnets
      "private_subnets" = data.terraform_remote_state.vpc.outputs.public_subnets
  }
}


output "data_azs_subnets" { value = data.terraform_remote_state.vpc.outputs.azs_subnets }
output "data_azs_private" { value = data.terraform_remote_state.vpc.outputs.azs_private }
output "data_azs_public"  { value = data.terraform_remote_state.vpc.outputs.azs_public  }
