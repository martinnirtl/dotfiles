#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▄░█▀▄░█▀▀░█░█
░█▀▄░█▀▄░█▀▀░█▄█
░▀▀░░▀░▀░▀▀▀░▀░▀

EOF

exit_on_disabled "$0"

echo "Checking for Brew binary on path..."
if ! command -v brew &> /dev/null
then
  echo "ERROR: Brew not installed"
  exit 1
else
  prompt_to_continue "Update Brew formulas?"
  brew update
  echo
  echo "Finished brew upgrade"
  echo "Don't forget to backup Brewfile via 'brew bundle dump'..."
fi

