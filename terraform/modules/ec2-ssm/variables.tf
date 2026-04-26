
variable "name"          { default = "ssm-server" }
variable "instance_type" { default = "t3.micro"   }
variable "ami_id"        { default = "" }

variable "subnet_id" {}

variable "root_block_device" {
  type = object({
    delete_on_termination = optional(bool)
    encrypted             = optional(bool)
    iops                  = optional(number)
    kms_key_id            = optional(string)
    tags                  = optional(map(string))
    throughput            = optional(number)
    size                  = optional(number)
    type                  = optional(string)
  })
  default = {}
}

variable "key_name"     { default = null }
variable "key_ssm_path" { default = null }
variable "user_data"    { default = null }

variable "tags" {
  type    = map(string)
  default = {}
}
