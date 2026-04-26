#!/usr/bin/env bash
#

##
## via Packer
##
set -x
/bin/bash gen.index-html.ec2-info.sh


cd /usr/share/nginx/html/
sudo /bin/cp index.html index-nginx.html
sudo /bin/cp /deploy/index-ec2-info/index.html .
set +x
