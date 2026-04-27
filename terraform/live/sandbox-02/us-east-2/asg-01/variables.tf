
variable "customer"      { default = "acme" }

variable "instance_type" { default = "t3.micro"   }
variable "ami_id"        { default = "" }

variable "lb_target_group_arn" { default = "" }

variable "user_data" { default = "" }

# self discovery (using ../common.auto.tfvars)
variable "ami_owners" { default = "" }
variable "ami_name"   { default = "" }
