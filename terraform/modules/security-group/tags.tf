
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/security-group"
    "mv:automation:module_type" = "resource"
  })
}
