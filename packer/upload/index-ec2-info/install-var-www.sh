#!/usr/bin/env bash
#

##
## via Packer
##

# apache DocumentRoot
_dir=/var/www/html/

echo "=== Install index.html [ec2-info]"
echo "===== _dir: [${_dir}]"

set -x

# generate
/bin/bash gen.index-html.ec2-info.sh

# publish
/bin/cp index.html ${_dir}/

set +x
