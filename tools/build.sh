#!/bin/bash
set -e

PLUGINS_BRANCH=${1:-stable/27.1}

echo "Using plugins branch: ${PLUGINS_BRANCH}"
echo "==="

cd /root
rm -rf /root/opnsense-plugin-autossh
git clone https://github.com/tom-berning-code/opnsense-plugin-autossh.git

cd /usr/plugins
git fetch origin
git checkout ${PLUGINS_BRANCH}
git pull --ff-only

rm -rf /usr/plugins/devel/autossh
mkdir -p /usr/plugins/devel/autossh
cp -r /root/opnsense-plugin-autossh/* /usr/plugins/devel/autossh/

cd /usr/plugins/devel/autossh
make clean 2>/dev/null; rm -rf work
make package
ls -la work/pkg/*.pkg