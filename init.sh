#!/bin/bash

DEV_HOME=$HOME/Development

echo "💠 Creating Development folder under $HOME..."
if [ -d "$DEV_HOME" ];
then
	echo "✅   Directory already exists."
else
  mkdir $DEV_HOME
fi

echo "💠 Checking for prerequisites..."
xcode-select -p > /dev/null # run and save return value in next step
RETURN_VALUE=$?
if [ $RETURN_VALUE -ne 0 ];
then
  xcode-select --install # prerequisitexcode-select -p
else
  echo "✅   Xcode command line tools are installed."
fi

echo "💠 Installing Brew..."
if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅   Brew is already installed. Skipping..."
fi

echo "💠 Installing chezmoi..."
if ! command -v chezmoi &> /dev/null
then
  brew install chezmoi
else
  echo "✅   Chezmoi already installed. Attempting upgrade..."
  brew upgrade chezmoi
fi

echo "💠 Initializing and applying chezmoi over SSH..."
# chezmoi init martinnirtl/dotfiles --apply --source $DEV_HOME/chezmoi --ssh # wait for https://github.com/twpayne/chezmoi/issues/2771
chezmoi init martinnirtl/dotfiles --apply --ssh