#!/usr/bin/env bash
#

##
## via Packer
##
set -x
/bin/bash gen.index-html.ec2-info.sh
/bin/sudo /bin/cp index.html /var/www/html/
set +x
