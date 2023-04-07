#!/bin/bash

cat << EOF

░█▀▄░█▀▄░█▀▀░█░█
░█▀▄░█▀▄░█▀▀░█▄█
░▀▀░░▀░▀░▀▀▀░▀░▀

EOF

if ! [ -z ${DISABLE_CHECKER_BREW} ]; then
  echo "Checker Brew: disabled"
  exit 0
fi

echo "Checking for brew..."
if ! command -v brew &> /dev/null
then
  echo "ERROR: Brew not installed"
  exit 1
else
  echo "Found. Attempting update..."
  brew update
  echo
  echo "Finished brew upgrade"
  echo "Don't forget to backup Brewfile via 'brew bundle dump'..."
fi

