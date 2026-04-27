
##
## LB
##

/****/
output  "nlb_id"          {  value = module.nlb.id          }
output  "nlb_arn"         {  value = module.nlb.arn         }
output  "nlb_dns_name"    {  value = module.nlb.dns_name    }
output  "nlb_zone_id"     {  value = module.nlb.zone_id     }

output "listeners_data" {
  value = {
    for k in keys(module.nlb.listeners):
      k => tomap({
        "protocol"  = module.nlb.listeners[k].protocol
        "port"      = module.nlb.listeners[k].port
      })
  }
}

output "listener_rules_all" { value = module.nlb.listener_rules }


#utput "target_groups_all"  { value = module.nlb.target_groups }
#utput "target_groups_keys" { value = [ for k in keys(module.nlb.target_groups): k ] }
output "target_groups_data" {
  value = {
    for k in keys(module.nlb.target_groups):
      k => tomap({
        "arn"             = module.nlb.target_groups[k].arn
        "health_check_0"  = module.nlb.target_groups[k].health_check[0].enabled
        "ip_address_type" = module.nlb.target_groups[k].ip_address_type
        "name"            = module.nlb.target_groups[k].name
        "port"            = module.nlb.target_groups[k].port
        "protocol"        = module.nlb.target_groups[k].protocol
        "target_type"     = module.nlb.target_groups[k].target_type
      })
  }
}

/****/

output "sg_id"                { value = module.sg.sg_id }
#utput "sg_rules_ingress_all" { value = module.sg.sg_rules_ingress_all }
#utput "sg_rules_egress_all"  { value = module.sg.sg_rules_egress_all  }

output "sg_rules_ingress" { value = module.sg.sg_rules_ingress }
output "sg_rules_egress"  { value = module.sg.sg_rules_egress  }

/****/
