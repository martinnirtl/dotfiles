#!/bin/bash

echo
echo "░█▀▀░█░█░█▀▀░█░░░█░░░░░▀█▀░█▀█░▀█▀░▀█▀"
echo "░▀▀█░█▀█░█▀▀░█░░░█░░░░░░█░░█░█░░█░░░█░"
echo "░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░▀░▀░▀▀▀░░▀░"
echo

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This setup is for MacOS only! Exitting..."
    exit 0
fi

DEV=$HOME/Development
DEV_TOOLS=$DEV/tools
DEV_TOOLS_BIN=$DEV/tools/bin

echo "Creating Development (and tools) folder under $HOME..."
if [ -d "$DEV_TOOLS_BIN" ];
then
	echo "Directory already exists."
else
  mkdir -p $DEV_TOOLS_BIN
fi

echo "Checking for prerequisites..."
xcode-select -p > /dev/null # run and save return value in next step
RETURN_VALUE=$?
if [ $RETURN_VALUE -ne 0 ];
then
  xcode-select --install # prerequisitexcode-select -p
else
  echo "Xcode command line tools are installed."
fi

echo "Installing Brew..."
if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Brew is already installed. Skipping..."
fi

echo "Installing chezmoi..."
if ! command -v chezmoi &> /dev/null
then
  brew install chezmoi
else
  echo "Chezmoi already installed. Attempting upgrade..."
  brew upgrade chezmoi
fi

echo "Initializing and applying chezmoi over SSH..."
# chezmoi init martinnirtl/dotfiles --apply --source $DEV/chezmoi --ssh # wait for https://github.com/twpayne/chezmoi/issues/2771
chezmoi init github.com/martinnirtl/dotfiles --branch main --apply --ssh
