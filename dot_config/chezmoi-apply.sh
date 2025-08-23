#!/bin/bash

CYAN='\033[38;5;51m'    # Bright cyan (xterm 51)
NC='\033[0m'            # Reset to default color

# CHEZMOI APPLY CHECKER
LAST_APPLY=$(date -j -r $HOME/.config/chezmoi_last-apply.txt +"%s")
LAST_APPLY_READABLE=$(date -j -f "%s" $LAST_APPLY)
if [ $(date -v -7d +"%s") -ge $LAST_APPLY ]; then
  echo -e "${CYAN}Run 'chezmoi apply' (last apply: $LAST_APPLY_READABLE)?${NC} Y/n"
  while true; do
    read -sn 1 yn
    case $yn in
      [Nn]* )
        break
        ;;
      [Yy]* )
        chezmoi apply
        break
        ;;
      * )
        if [ -z ${yn} ]; then
          chezmoi apply
          break
        fi
        ;;
    esac
  done
fi
