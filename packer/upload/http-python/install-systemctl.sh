#!/usr/bin/env bash

echo "=== SystemD files: /etc/systemd/system/"

# Skip systemctl if docker
# if test "$DOCKER" == "true"  \
[[ -f /.dockerenv ]] && {
  echo "=== SystemD docker: skipping"
  exit 0
}

set -x

# chmod 640
# chwon 0:0
install -m 640 -o 0 -g 0 http-python.service /etc/systemd/system/

systemctl enable http-python.service
systemctl start  http-python.service
systemctl status http-python.service

set +x
