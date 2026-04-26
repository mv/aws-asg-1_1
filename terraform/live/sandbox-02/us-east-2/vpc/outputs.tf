
output  "vpc_id"                                 { value = module.vpc.vpc_id                                }
output  "vpc_cidr_block"                         { value = module.vpc.vpc_cidr_block                        }
output  "vpc_default_security_group_id"          { value = module.vpc.default_security_group_id             }
output  "vpc_owner_id"                           { value = module.vpc.vpc_owner_id                          }
output  "vpc_azs"                                { value = module.vpc.azs                                   }

#utput  "vpc_enable_dns_support"                 { value = module.vpc.vpc_enable_dns_support                }
#utput  "vpc_enable_dns_hostnames"               { value = module.vpc.vpc_enable_dns_hostnames              }
#utput  "vpc_secondary_cidr_blocks"              { value = module.vpc.vpc_secondary_cidr_blocks             }

output  "private_subnets"                        { value = module.vpc.private_subnets                       }
output  "private_subnets_cidr_blocks"            { value = module.vpc.private_subnets_cidr_blocks           }

output  "public_subnets"                         { value = module.vpc.public_subnets                        }
output  "public_subnets_cidr_blocks"             { value = module.vpc.public_subnets_cidr_blocks            }

output  "nat_public_ips"                         { value = module.vpc.nat_public_ips                        }
output  "natgw_ids"                              { value = module.vpc.natgw_ids                             }

output  "default_vpc_id"                         { value = module.vpc.default_vpc_id                        }
output  "default_vpc_cidr_block"                 { value = module.vpc.default_vpc_cidr_block                }
output  "default_vpc_default_security_group_id"  { value = module.vpc.default_vpc_default_security_group_id }
#utput  "vpc_endpoints_security_group_id"        { value = module.vpc_endpoints.security_group_id           }

#utput  "database_subnet_group"                  { value = module.vpc.database_subnet_group                 }
#utput  "database_subnets"                       { value = module.vpc.database_subnets                      }
#utput  "database_subnets_cidr_blocks"           { value = module.vpc.database_subnets_cidr_blocks          }
