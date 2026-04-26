
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v6.6.1"

  name = "vpc-sandbox-02"
  cidr = "10.100.0.0/16"

  azs              = ["us-east-2a"    , "us-east-2b"    ] # , "us-east-2c"  ]
  public_subnets   = ["10.100.11.0/24", "10.100.12.0/24"] # , "10.100.13.0/24"]
  private_subnets  = ["10.100.21.0/24", "10.100.22.0/24"] # , "10.100.23.0/24"]
# database_subnets = ["10.100.31.0/24", "10.100.32.0/24"] # , "10.100.33.0/24"]

  public_subnet_names   = ["public-a" , "public-b" ] #, "public-c"  ]
  private_subnet_names  = ["private-a", "private-b"] #, "private-c" ]
# database_subnet_names = ["db-a"     , "db-b"     ] #, "db-c"      ]

  enable_nat_gateway     = true
  single_nat_gateway     = true  # dev: true | prod: false
# one_nat_gateway_per_az = true  # prod: true

  tags = {
    Terraform   = "true"
    Environment = "sandbox"
  }
}
