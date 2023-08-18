#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

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
  prompt_to_continue "Do you want to update Brew formulas?" "Y" 0 "No brew today."
  brew update
  echo
  echo "Finished brew upgrade"
  echo "Don't forget to backup Brewfile via 'brew bundle dump'..."
fi

