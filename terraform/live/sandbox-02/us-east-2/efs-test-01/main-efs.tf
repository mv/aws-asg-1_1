locals {
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  azs         = data.terraform_remote_state.vpc.outputs.vpc_azs
  subnets     = data.terraform_remote_state.vpc.outputs.private_subnets
# azs_subnets = data.terraform_remote_state.vpc.outputs.azs_subnets
  name        = "test-01"
}

module "efs" {
  source  = "terraform-aws-modules/efs/aws"
  version = "2.2.0"

  # File system
  name   = local.name

  # VPC Mount targets
# mount_targets = local.azs_subnets
  mount_targets = {
    for k, v in zipmap(local.azs, local.subnets) : k => { subnet_id = v }
  }

# mount_targets = {
#   "us-east-2b" = { subnet_id = "subnet-07907f2896f6eed1c" }
#   "us-east-2a" = { subnet_id = "subnet-0c36d857b32d5d902" }
#   "us-east-2c" = { subnet_id = "subnet-fghi345a" }
# }

  create_security_group        = true
  security_group_vpc_id        = local.vpc_id
  security_group_name          = "efs-${local.name}"
  security_group_description   = "EFS: [${local.name}] security group"
  security_group_ingress_rules = {
    nfs_10  = { cidr_ipv4 = "10.0.0.0/8"     }
    nfs_172 = { cidr_ipv4 = "172.16.0.0/12"  }
    nfs_192 = { cidr_ipv4 = "192.168.0.0/16" }
    nfs_100 = { cidr_ipv4 = "100.99.0.0/16"  }
  }

  # Access point(s)
  access_points = {
    config = {
      root_directory = { path = "/web/config", creation_info = { owner_gid = 1001, owner_uid = 1001, permissions = "755" } }
      posix_user     = { uid = 1001, gid = 1001 }
    }
    log = {
      root_directory = { path = "/web/log"   , creation_info = { owner_gid = 1001, owner_uid = 1001, permissions = "755" } }
      posix_user     = { uid = 1001, gid = 1001 }
    }
  }

  encrypted     = false
  attach_policy = false

  create_backup_policy = false
  enable_backup_policy = false

  create_replication_configuration = false

  throughput_mode = "bursting"  # bursting | elastic | provisioned
  performance_mode = "generalPurpose" # generalPurpose | maxIO

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
