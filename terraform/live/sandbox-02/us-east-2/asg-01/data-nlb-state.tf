# vscode-modelines
# vim: set ft=terraform:

data "terraform_remote_state" "nlb" {
  backend = "local"

  config = {
    path = "../nlb-test-01/terraform.tfstate"
  }
}


#utput "data_nlb_all"       { value = data.terraform_remote_state.nlb }
#utput "data_nlb_target_80" { value = data.terraform_remote_state.nlb.outputs.target_groups_data.target_80.arn }

output "data_nlb" {
  value = {
    tomap = {
      "lb_dns"     = data.terraform_remote_state.nlb.outputs.nlb_dns_name
      "lb_url"     = "http://${data.terraform_remote_state.nlb.outputs.nlb_dns_name}/"
      "target_80"  = data.terraform_remote_state.nlb.outputs.target_groups_data.target_80.arn
      "target_443" = data.terraform_remote_state.nlb.outputs.target_groups_data.target_443.arn
    }
  }
}
/***/