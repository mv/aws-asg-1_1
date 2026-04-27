locals {
  name     = "asg-01"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets  = data.terraform_remote_state.vpc.outputs.private_subnets
  targetg  = data.terraform_remote_state.nlb.outputs.target_groups_data.target_80.arn
  ami_id   = data.aws_ami.ami.image_id

  customer = "test"
}

/****/
module "asg" {
# source = "../../../../../modules/autoscaling-ec2"
  source = "../../../../modules/autoscaling-ec2"

  customer            = local.customer
  instance_type       = var.instance_type
  ami_id              = local.ami_id
  sg_id               = module.sg.sg_id

  lb_target_group_arn = local.targetg
  vpc_zone_identifier = local.subnets

# ami_ssm_path = "/app/asg/${var.customer}/ami"

  # Ref: https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-metrics.html
  asg_enabled_metrics    = true  # ASG extra metrics

  # Ref: https://docs.aws.amazon.com/autoscaling/ec2/userguide/enable-as-instance-metrics.html
  lt_detailed_monitoring = true  # EC2 1 minute metrics

##
## Launch Template: deploy stuff

# iam_role_policies = {
#   ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
# }


# user_data = ""
  user_data = <<-EOT
    #!/bin/bash

    cd /deploy/index-ec2-info/
    bash gen.index-html.ec2-info.sh
    sudo /bin/cp index.html /usr/share/nginx/html/

  EOT
# user_data = filebase64(var.user_data)

  tags = {
    "asg:env"     = "dev"
    "asg:customer" = var.customer
  }

}

/***/