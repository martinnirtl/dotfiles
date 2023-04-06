#!/bin/bash

echo
echo "░█▀▄░█░█░█▀▀░▀█▀"
echo "░█▀▄░█░█░▀▀█░░█░"
echo "░▀░▀░▀▀▀░▀▀▀░░▀░"
echo

echo "Checking for rust toolchain..."
if command -v rustc &> /dev/null; then
  echo "Rust already installed. Running update..."
  rustup update
  echo "Rust update done!"
  exit 0
else
  echo "Rust not found..."
fi

while true; do
  read -p "Install Rust? Y/n" yn
  case $yn in
    [Nn]* ) 
      exit 0
      ;;
    [Yy]* )
      break
      ;;
    * )
      if [[ $yn == $'\n' ]]; then
        break
      fi
      ;;
  esac
done

echo "Installing Rust... (see https://www.rust-lang.org/tools/install)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo
echo "Uninstall with `rustup self uninstall`." 
