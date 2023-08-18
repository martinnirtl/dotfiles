#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▀░█▀█░█░░░█▀█░█▀█░█▀▀
░█░█░█░█░█░░░█▀█░█░█░█░█
░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀

EOF

exit_on_disabled "$0"

GOROOT=$(go env GOROOT)
# Check GOROOT - this gets changed by brew's go
if ! [ -z ${GOROOT} ] && [ "$GOROOT" != "/usr/local/go" ]; then
  echo "WARNING: GOROOT is set to '${GOROOT}'"
else
  echo "GOROOT is set to '${GOROOT}'"
fi
echo

echo "Checking latest stable go version"
LATEST_PKG=$(curl -s https://go.dev/dl/?mode=json | grep -o 'go.*.darwin-arm64.pkg' | head -n 1 | tr -d '\r\n')
LATEST_VERSION=$(echo $LATEST_PKG | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
LATEST_DOWNLOAD="https://go.dev/dl/${LATEST_PKG}"

INSTALLED_VERSION=$(go version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')

if [ "$LATEST_VERSION" != "$INSTALLED_VERSION" ] || [ -z ${INSTALLED_VERSION} ]; then
  prompt_to_continue "Do you want to install/update go?" "Y" 0 "No go update today."
  echo "Installing go: ${LATEST_PKG}" && \
  curl -OL $LATEST_DOWNLOAD && \
  sudo installer -pkg $LATEST_PKG -target / && \
  rm $LATEST_PKG && \
  echo "Golang installed." && \
  exit 0

  echo "Install failed!"

else
  echo "Latest go version already installed"
fi

#. go_installs.sh
