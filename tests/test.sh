#!/usr/bin/env bash

[[ -n $DEBUG ]] && set -x -e

cwd=`dirname "$0"`

echo "Import files into configmap \"mycm\""
kubectl create configmap mycm --from-file ${cwd}/files

echo "Export configmap \"mycm\" into files in directry \"exports\""
if [ ! -d "${cwd}/exports" ]; then
  mkdir -p ${cwd}/exports
fi
${cwd}/../kube-configmap-exporter mycm -t ${cwd}/exports

echo "Check exported files"
for i in $(ls -1 ${cwd}/files/*)
do
  f=$(basename $i)
  o="${cwd}/exports/${f}"
  if [ ! -f ${o} ]; then
    echo "Error: ${f} wasn't exported as expected" >&2
    exit 1
  fi
  BEFORE=$(shasum -a 256 $i |awk '{print $1}')
  AFTER=$(shasum -a 256 $o|awk '{print $1}')
  if [ "${BEFORE}" != "${AFTER}" ];then
    echo "Error: exported file isn't the same as the original one: ${f}" >&2
    exit 1
  fi
done

echo "Remove configmap \"mycm\" and exported files"
kubectl delete configmap mycm
rm -rf ${cwd}/exports

echo "Success!"
