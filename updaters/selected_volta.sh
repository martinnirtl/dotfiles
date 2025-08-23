#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

lolcat << EOF

░█░█░█▀█░█░░░▀█▀░█▀█
░▀▄▀░█░█░█░░░░█░░█▀█
░░▀░░▀▀▀░▀▀▀░░▀░░▀░▀

EOF

echo "Running volta installation..."
echo

curl https://get.volta.sh | bash -s -- --skip-setup

echo
echo "Warning: Set the VOLTA_HOME variable to \$HOME/.volta"
echo "Warning: Add \$VOLTA_HOME/bin to the beginning of your PATH variable"


