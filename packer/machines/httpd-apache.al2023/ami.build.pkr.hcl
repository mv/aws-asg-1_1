
##
## Build + provisioning
##
locals {
  index_name = "index-ec2-info"
  index_dir  = "/deploy"
  index_cmd  = "bash -x ./gen.index-html.ec2-info.sh"
  index_dst  = "/var/www/html"
}

build {
  sources = [ "source.amazon-ebs.al2023" ]

  provisioner "shell" {
    inline = [
      "echo ===",
      "echo ===",
      "echo === Connected via SSM at [${build.User}@${build.Host}:${build.Port}]",
      "echo ===",
      "echo ===",
      "echo ===== Initial setup",
    ]
  }

  ##
  ## Initial setup
  ##
  provisioner "shell" {
    scripts = [
      "../../scripts/dir-deploy/by-ec2-user.sh",
      "../../scripts/httpd-apache/dnf-install.sh",
      "../../scripts/install-extras/dnf-install.sh",
    ]
  }

  ##
  ## Upload dirs
  ##
  provisioner "file" {
    sources = [
      "../../upload/index-ec2-info",
      "../../upload/index-deploy",
    ]
    destination = "/deploy/"
  }


  ##
  ## index page: ec2-info
  ##
  provisioner "shell" {
    inline = [
      "echo ===== Install index.html [ec2-info]",
      "cd /deploy/index-ec2-info/ && bash install-var-www.sh",
    ]
  }

  ##
  ## Breakpoint: check provisioning before commiting a new AMI
  ##
  /*****/
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check provisioning...."
  }
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check provisioning....1"
  }
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check provisioning....2"
  }
  /*****/

}
