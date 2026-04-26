
variable "name"          { default = "web-server" }
variable "instance_type" { default = "t3.micro"   }
variable "ami_id"        { default = "" }

variable "subnet_id"     {}
variable "key_name"      { default = "" }

variable "tags" {
  type    = map(string)
  default = {}
}
