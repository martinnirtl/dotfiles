#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▀░█▀▀░█░░░█▀█░█░█░█▀▄
░█░█░█░░░█░░░█░█░█░█░█░█
░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀░

EOF

exit_on_disabled "$0"

echo "WARNING: This script does only check for 'gcloud' being on the PATH!" 
echo

if command -v gcloud &> /dev/null; then
  prompt_to_continue "Update gcloud?"
  gcloud components update
else
  echo "The gcloud CLI is not installed"
  echo "Install gcloud by downloading an archive from https://cloud.google.com/sdk/docs/install (check instructions)"
  echo "Extract the archive to $GCLOUD_INSTALL"
  echo "Run ./install.sh"
fi
