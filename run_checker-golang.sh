#!/bin/bash

echo
echo "░█▀▀░█▀█░█░░░█▀█░█▀█░█▀▀"
echo "░█░█░█░█░█░░░█▀█░█░█░█░█"
echo "░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀"
echo

#  TODO implement for all checkers
if ! [ -z ${DISABLE_CHECKER_GOLANG} ]; then
  echo "Checker Golang: disabled"
  exit 0
fi

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
  while true; do
      read -p "Install/Upgrade go $LATEST_VERSION? Y/n" yn # TODO read in char w/o enter
      case $yn in
          [Nn]* ) exit 0;;
          * )
            echo "Installing go: ${LATEST_PKG}" && \
            curl -OL $LATEST_DOWNLOAD && \
            sudo installer -pkg $LATEST_PKG -target / && \
            rm $LATEST_PKG && \
            echo "Golang installed." && \
            exit 0

            echo "Install failed!"
            ;;
      esac
  done
else
  echo "Latest go version already installed"
fi

#. go_installs.sh
