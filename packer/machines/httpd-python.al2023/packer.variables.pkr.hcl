# vscode-modelines
# vim: set ft=hcl:

variable "instance_type" { default = "t3.micro" }


##
## must be set via env vars
##   $ source ./variables.sh
##
variable "region"    { default = "" }
variable "vpc_id"    { default = "" }
variable "subnet_id" { default = "" }
variable "sg_id"     { default = "" }

variable "iam_instance_profile" { default = "" }

##
## deploy
##
variable "release" {
  type    = string
  default = "test"
}
