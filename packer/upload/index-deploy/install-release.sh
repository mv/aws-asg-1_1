
[[ ${1} == "" ]] && {
  echo
  echo "Usage: $0 release"
  echo
  echo "  release: blue|green|test"
  echo
  exit 1
}

_rel="${1}"

echo "=== Define release: [${_rel}]"
/bin/cp index-${_rel}.html index.html
