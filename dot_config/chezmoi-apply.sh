#!/bin/bash

# CHEZMOI APPLY CHECKER
LAST_APPLY=$(date -j -r $HOME/.config/chezmoi_last-apply.txt +"%s")
LAST_APPLY_READABLE=$(date -j -f "%s" $LAST_APPLY)
if [ $(date -v -7d +"%s") -ge $LAST_APPLY ]; then
  echo "Run 'chezmoi apply' (last apply: $LAST_APPLY_READABLE)? Y/n"
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
