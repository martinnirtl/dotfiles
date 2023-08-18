#!/bin/bash

cat << EOF
    ____      _ __  _       ___           
   /  _/___  (_) /_(_)___ _/ (_)___  ___  
   / // __ \/ / __/ / __ '/ / /_  / / _ \ 
 _/ // / / / / /_/ / /_/ / / / / /_/  __/ 
/___/_/ /_/_/\__/_/\__,_/_/_/ /___/\___/  
                                          
EOF

if ! command -v chezmoi &> /dev/null
then
  echo "Chezmoi not installed. Did you run 'setup.sh' script? Exiting..."
  exit 1
fi

CHEZMOI_SOURCE=$(chezmoi source-path)

echo "Checking for Brew command..."
if ! command -v brew &> /dev/null
then
  echo "Brew not installed. Did you run 'setup.sh' script? Exiting..."
  exit 1
else
  echo "Brew is installed. Attempting update..."
  brew update

  echo "Installing Brew formulas from Brewfile..."
  brew bundle --no-lock --file="$CHEZMOI_SOURCE/Brewfile"
fi

# Krew can be installed before kubernetes-cli/kubectl, which gets installed during 'brew bundle'
echo "Installing Krew..."
if [ -d "$HOME/.krew" ]; # checking the default install dir
then
	echo "Krew found under $HOME/.krew. Attempting update..."
  kubectl-krew upgrade
else
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
fi

echo "Installing kubectl plugins via Krew..."
kubectl-krew install < "$CHEZMOI_SOURCE/kubectl-plugins.txt"

echo "Installing OH-MY-ZSH..."
if [ -d "$ZSH" ];
then
	echo "OH-MY-ZSH is installed under $ZSH. Attempting update..."
  omz update
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Git-cloning OH-MY-ZSH plugins... (ignoring errors)"
ZSH_PLUGIN=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if ! [ -d "$ZSH_PLUGIN" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGIN
else
  echo "Skipping zsh-autosuggestions. Already installed..."
fi
ZSH_PLUGIN=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if ! [ -d "$ZSH_PLUGIN" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGIN
else
  echo "Skipping zsh-syntax-highlighting. Already installed..."
fi
