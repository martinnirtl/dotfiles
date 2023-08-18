#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▀░▀█▀░█░░░▀█▀░█░█░█▄█
░█░░░░█░░█░░░░█░░█░█░█░█
░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀

EOF

if ! [ -z ${DISABLE_CHECKER_CILIUM} ]; then
  echo "Checker cilium: disabled"
  exit 0
fi

prompt_to_continue "Do you want to update Cilium CLI?" "Y" 0 "No Cilium update today."
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "arm64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}
shasum -a 256 -c cilium-darwin-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-darwin-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}
