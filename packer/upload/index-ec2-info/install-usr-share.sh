#!/usr/bin/env bash
#

##
## via Packer
##

# nginx tree
_dir=/usr/share/nginx/html/

echo "=== Install index.html [ec2-info]"
echo "===== _dir: [${_dir}]"

set -x

# generate
/bin/bash gen.index-html.ec2-info.sh

# just in case: save original
/bin/cp ${_dir}/index.html ${_dir}/index-nginx.html

# publish
/bin/cp       ./index.html ${_dir}/

set +x
