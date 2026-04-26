##
## IMG name
##

source "docker" "al2023" {
# image  = "amazonlinux:2023"
  image  = "almalinux-10:packer"
  pull   = false   # use locally built
  commit = true
  changes = [
    "ENV DOCKER true",
  ]
}
