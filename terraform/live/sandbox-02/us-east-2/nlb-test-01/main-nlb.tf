

locals {
  vpc_id  = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets = data.terraform_remote_state.vpc.outputs.public_subnets

  health_check = {
    enabled             = true
    protocol            = "TCP"
    timeout             = 6
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  name = "nlb-test-01"

}

/*****/
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  ##
  ## NLB
  ##
  load_balancer_type = "network"
  internal           = false

  name               = local.name    # var.name
  vpc_id             = local.vpc_id  # var.vpc_id  # "vpc-abcde012"
  subnets            = local.subnets # var.subnets # ["subnet-abcde012", "subnet-bcde012a"]

# enable_deletion_protection = var.enable_deletion_protection
  enable_deletion_protection = false

  ##
  ## Listener(s) / Target Group(s)
  ##
  listeners = {
    tcp_80 = {
      port     = 80
      protocol = "TCP"
      forward = { target_group_key = "target_80" }
    }

    tcp_443 = {
      port     = 443
      protocol = "TCP"
      forward = { target_group_key = "target_443" }
    }

  }

  target_groups = {
    target_80 = {
#     name_prefix = "tg80-"
      name        = "${local.name}-tg80"
      protocol    = "TCP"
      port        = 80
      vpc_id      = local.vpc_id

      create_attachment = false

      health_check = local.health_check
    }

    target_443 = {
#     name_prefix = "tg443-"
      name        = "${local.name}-tg443"
      protocol    = "TCP"
      port        = 443
      vpc_id      = local.vpc_id

      create_attachment = false

      health_check = local.health_check
    }

  }

  ##
  ## LB: Security Group
  ##
  create_security_group = false
  security_groups       = [module.sg.sg_id]  # use my 'sg'

  ##
  ## TODO: LB Access Logs
  ##
# access_logs = {
#   bucket = "my-nlb-logs"
# }

}

  ## TODO: Health Checks
  ## Ref: https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-health-checks.html#health-check-settings
  ##

/*****/