
output  "efs_arn"            { value = module.efs.arn                }
output  "efs_id"             { value = module.efs.id                 }
output  "efs_mount_targets"  { value = module.efs.mount_targets      }
output  "efs_access_points"  { value = module.efs.access_points      }
output  "efs_size_in_bytes"  { value = module.efs.size_in_bytes      }

output  "dns_name"           { value = module.efs.dns_name           }

output  "security_group_arn" { value = module.efs.security_group_arn }
output  "security_group_id"  { value = module.efs.security_group_id  }


# output  "replication_configuration_destination_file_system_id"  {
#   value  =  module.efs.replication_configuration_destination_file_system_id
# }