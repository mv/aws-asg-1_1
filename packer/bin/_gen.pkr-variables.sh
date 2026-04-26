#!/usr/bin/env bash
# vscode-modelines
# vim: set ft=bash:

usage() {
  echo
  echo "Usage: $0 env.filter"
  echo
  echo "  Generate '_variable.sh' from 'env.filter' file"
  echo
  exit 1
}

[[ ${1} == "" ]] && usage

source "${1}"

echo "=="
echo "== Filters"
echo "==     vpc_tag_name: [${vpc_tag_name}]"
echo "==  subnet_tag_name: [${subnet_tag_name}]"
echo "==      sg_tag_name: [${sg_tag_name}]"
echo "=="
echo "== Values"
echo "==   instance_profile_name: [${instance_profile_name}]"
echo "==                  region: [${region}]"
echo "=="

set -x
_vpc_id=$(    aws ec2 describe-vpcs            --query 'Vpcs[].[VpcId]'             --filters "Name=tag:Name,Values=${vpc_tag_name}"    --output text )
_subnet_id=$( aws ec2 describe-subnets         --query 'Subnets[].[SubnetId]'       --filters "Name=tag:Name,Values=${subnet_tag_name}" --output text )
_sg_id=$(     aws ec2 describe-security-groups --query 'SecurityGroups[].[GroupId]' --filters "Name=tag:Name,Values=${sg_tag_name}"     --output text )

_instanceprofile_id="${instance_profile_name}"
_region="${region}"
set +x

cat > _variables.sh <<'EOF'
#!/usr/bin/env bash
# vscode-modelines
# vim: set ft=bash:

usage() {
  echo
  echo "Usage: source $0"
  echo
  echo "This file must be 'sourced'"
  echo "  $ source $0"
  echo
  exit 1
}
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && usage

echo
echo "== Sourcing: [_variables.sh]"
echo


export PKR_VAR_vpc_id="__vpcid__"
export PKR_VAR_subnet_id="__subnetid__"
export PKR_VAR_sg_id="__sgid__"
export PKR_VAR_iam_instance_profile="__instanceprofile__"
export PKR_VAR_region="__region__"

EOF

sed -i -e "s/__vpcid__/${_vpc_id}/g"       _variables.sh
sed -i -e "s/__subnetid__/${_subnet_id}/g" _variables.sh
sed -i -e "s/__sgid__/${_sg_id}/g"         _variables.sh
sed -i -e "s/__instanceprofile__/${_instanceprofile_id}/g" _variables.sh
sed -i -e "s/__region__/${_region}/g"      _variables.sh

[ -f ./_variables.sh-e ] && /bin/rm ./_variables.sh-e

cat -n ./_variables.sh
