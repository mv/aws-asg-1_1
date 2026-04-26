# vscode-modelines
# vim: set ft=HCL:

##
## Build + provisioning
##
build {
  sources = [
    "source.docker.al2023",
  ]

  provisioner "shell" {
    inline = [
      "echo ===",
      "echo ===",
      "echo === Connected via Docker at [${build.User}@${build.Host}:${build.Port}]",
      "echo ===",
      "echo ===",
      "echo === Upload files: /tmp/www/",
      "mkdir -p /tmp/www/"
    ]
  }

  # upload dir
  provisioner "file" {
    sources     = [
      "../../upload/index-deploy",
      "../../upload/http-python",
    ]
    destination = "/tmp/www/"
  }

  # install
  provisioner "shell" {
    inline = [
      "cd /tmp/www/index-deploy/ &&      bash install-release.sh ${var.release}",
      "cd /tmp/www/index-deploy/ && sudo bash install-files.sh   /var/www",
      "cd /tmp/www/http-python/  && sudo bash install-systemctl.sh",
    ]
  }

  ##
  ## Breakpoint: check provisioning before commiting a new AMI
  ##
  /*****/
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check final....1"
  }
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check final....2"
  }
  /*****/

}
