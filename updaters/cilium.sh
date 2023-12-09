#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▀░▀█▀░█░░░▀█▀░█░█░█▄█
░█░░░░█░░█░░░░█░░█░█░█░█
░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀

EOF

exit_on_disabled "$0"

prompt_to_continue "Install/update Cilium CLI?"
LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
if command -v cilium &> /dev/null; then
  INSTALLED_VERSION=$(cilium version | head -1 | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
fi

if [ "$LATEST_VERSION" != "$INSTALLED_VERSION" ] || [ -z ${INSTALLED_VERSION} ]; then
  if [ -z "${INSTALLED_VERSION}" ]; then
    echo "Installing cilium: ${LATEST_PKG}"
  else
    echo "Updating cilium from ${INSTALLED_VERSION} to ${LATEST_PKG}"
  fi

  # NOTE below steps copied from docs: https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli
  # CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
  CLI_ARCH=amd64
  if [ "$(uname -m)" = "arm64" ]; then CLI_ARCH=arm64; fi
  curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}
  shasum -a 256 -c cilium-darwin-${CLI_ARCH}.tar.gz.sha256sum
  sudo tar xzvfC cilium-darwin-${CLI_ARCH}.tar.gz /usr/local/bin
  rm cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}

else
  echo "Latest cilium version already installed"
fi
