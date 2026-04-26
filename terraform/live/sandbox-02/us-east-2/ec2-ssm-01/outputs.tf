
/*****/
output "ec2_instance_id"       { value = module.ssm-01.ec2_instance_id }
output "ec2_private_ip"        { value = module.ssm-01.ec2_private_ip }
output "ec2_public_ip"         { value = module.ssm-01.ec2_public_ip }
output "ec2_security_group_id" { value = module.ssm-01.ec2_security_group_id }
output "ec2_instance_type"     { value = module.ssm-01.ec2_instance_type }
output "ec2_name"              { value = module.ssm-01.ec2_name }
output "ec2_key_name"          { value = module.ssm-01.ec2_key_name }
output "ec2_key_ssm_path"      { value = module.ssm-01.ec2_key_ssm_path }

output "ssm_cli"               { value = module.ssm-01.ssm_cli }
/*****/
