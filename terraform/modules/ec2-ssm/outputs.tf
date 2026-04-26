
output "ec2_instance_id"       { value = module.ec2.id }
output "ec2_private_ip"        { value = module.ec2.private_ip }
output "ec2_public_ip"         { value = module.ec2.public_ip  }
output "ec2_security_group_id" { value = aws_security_group.sg.id }
output "ec2_instance_type"     { value = var.instance_type   }
output "ec2_name"              { value = var.name }
output "ec2_key_name"          { value = var.key_name }
output "ec2_key_ssm_path"      { value = var.key_ssm_path }

output "ssm_cli" { value = "aws ssm start-session --target ${module.ec2.id}" }
# output "ssm_connection_info"   { value = var.ssm_connection_info }

