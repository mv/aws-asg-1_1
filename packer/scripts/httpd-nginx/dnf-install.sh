
##
## via Packer
##
echo "=== Install httpd/nginx"

sudo dnf install -y nginx
sudo systemctl enable nginx
sudo systemctl start  nginx

echo "==="
