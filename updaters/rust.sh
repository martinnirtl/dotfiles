#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▄░█░█░█▀▀░▀█▀
░█▀▄░█░█░▀▀█░░█░
░▀░▀░▀▀▀░▀▀▀░░▀░

EOF

exit_on_disabled "$0"

echo "Checking for Rust toolchain..."
if command -v rustc &> /dev/null; then
  echo "Rust already installed."
  prompt_to_continue "Update Rust?"
  rustup update
  echo "Rust update done!"
  exit 0
else
  echo "Rust not found..."
fi

prompt_to_continue "Install Rust?"
echo "Installing Rust... (see https://www.rust-lang.org/tools/install)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo
echo "Uninstall with `rustup self uninstall`." 
