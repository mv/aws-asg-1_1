

echo "=== SystemD files: /etc/systemd/system/"

# chmod 640
# chwon 0:0
install -m 640 -o 0 -g 0 http-python.service /etc/systemd/system/
systemctl enable http-python.service
systemctl start  http-python.service
