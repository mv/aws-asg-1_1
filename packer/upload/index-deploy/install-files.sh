

[[ ${1} == "" ]] && {
  echo
  echo "Usage: $0 destination_dir"
  echo
  exit 1
}

_dir="${1}"
echo "=== Web files: [${1}]"

mkdir -p "${_dir}"
for f in *.png *.html
do
  echo "===== Web files: [${f}]"
  install -m 640 $f "${_dir}/"
done
