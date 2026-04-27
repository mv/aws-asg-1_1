
/****/
variable "name"        { default = "ec2-sg-01" }
variable "description" { default = "" }

variable "vpc_id"      { default = "" }

variable "ingress" {
  type    = map(any)
  default = {}
}

variable "egress" {
  type    = map(any)
  default = {}
}

variable "tags" {
  type    = map(any)
  default = {}
}

/****/