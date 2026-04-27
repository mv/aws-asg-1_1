
output "sg_id"  { value = aws_security_group.sg.id }

output "sg_rules_ingress_all" { value = aws_security_group_rule.ingress }
output "sg_rules_egress_all"  { value = aws_security_group_rule.egress  }

output "sg_rules_ingress" { value = "[ ${join(", ", keys(aws_security_group_rule.ingress))} ]" }
output "sg_rules_egress"  { value = "[ ${join(", ", keys(aws_security_group_rule.egress ))} ]" }