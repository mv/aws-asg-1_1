
##
## via Packer
##
echo "===== Install httpd/apache"

sudo dnf install -y httpd
sudo systemctl enable httpd
sudo systemctl start  httpd

echo "====="
