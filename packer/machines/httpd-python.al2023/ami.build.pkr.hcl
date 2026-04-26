# vscode-modelines
# vim: set ft=HCL:

##
## Build + provisioning
##
build {
  sources = [ "source.amazon-ebs.al2023" ]

  provisioner "shell" {
    inline = [
      "echo ===",
      "echo ===",
      "echo === Connected via SSM at [${build.User}@${build.Host}:${build.Port}]",
      "echo ===",
      "echo ===",
      "echo ===== Upload files",
      "echo ===",
      "mkdir -p /tmp/www/"
    ]
  }

  # upload dir
  provisioner "file" {
    sources     = [
      "../../upload/index-deploy/",
      "../../upload/http-python/",
    ]
    destination = "/tmp/www/"
  }

  # example: define a custom 'release'
  provisioner "shell" {
    inline = [
      "echo ===== Define release: [${var.release}]",
      "cd /tmp/www/ && /bin/cp index-${var.release}.html index.html",
    ]
  }

  /*****
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check 001...."
  }
  /*****/


  # install
  provisioner "shell" {
    inline = [
      "echo ===== Web files:   /var/www/",
      "sudo mkdir -p           /var/www/",
      "sudo /bin/cp /tmp/www/* /var/www/",

      "echo ===== SystemD files: /etc/systemd/system/",
      "sudo chmod 640 /tmp/www/http-python.service",
      "sudo chown 0:0 /tmp/www/http-python.service",
      "sudo /bin/cp   /tmp/www/http-python.service /etc/systemd/system/ || :",
      "sudo systemctl enable http-python.service || :",
      "sudo systemctl start  http-python.service || :",
#     "sudo cat       /tmp/www/http-python.service > /etc/systemd/system/http.service || :",
#     "sudo /bin/cp   /etc/systemd/system/http-python.service /etc/systemd/system/http.service || :",
#     "sudo systemctl enable http.service || :",
#     "sudo systemctl start  http.service || :",
    ]
  }

  ##
  ## Breakpoint: check provisioning before commiting a new AMI
  ##
  /*****/
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check final...."
  }
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
