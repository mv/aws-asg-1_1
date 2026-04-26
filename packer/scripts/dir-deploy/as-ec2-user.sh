
##
## via Packer
##
 _user="ec2-user"
_group="ec2-user"

echo "Create /deploy [${_user}:${_group}]"

sudo install -o ${_user} -g ${_group} -d /deploy

