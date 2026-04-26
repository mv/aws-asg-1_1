
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/ec2-webserver"
    "mv:automation:module_type" = "wrapper"
  })
}
