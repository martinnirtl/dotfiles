#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

lolcat << EOF

░█▀▄░█▀▄░█▀▀░█░█
░█▀▄░█▀▄░█▀▀░█▄█
░▀▀░░▀░▀░▀▀▀░▀░▀

EOF

echo "Checking for Brew binary on path..."
if ! command -v brew &> /dev/null
then
  echo "ERROR: Brew not installed"
  exit 1
else
  brew update
  brew upgrade
  echo
  echo "Finished brew upgrade"
  echo "Don't forget to backup Brewfile via 'scripts_backup-xrew'"
fi

