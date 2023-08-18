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
  prompt_to_continue "Do you want to update Rust?" "Y" 0 "No Rust update today."
  rustup update
  echo "Rust update done!"
  exit 0
else
  echo "Rust not found..."
fi

prompt_to_continue "Do you want to install Rust?" "Y" 0 "No Rust install today."
echo "Installing Rust... (see https://www.rust-lang.org/tools/install)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo
echo "Uninstall with `rustup self uninstall`." 
