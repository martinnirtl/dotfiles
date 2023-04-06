#! /opt/homebrew/bin/zsh
# TODO make this work in bash

# CHEZMOI APPLY CHECKER
LAST_APPLY=$(date -j -r $HOME/.config/chezmoi_last-apply.txt +"%s")
LAST_APPLY_READABLE=$(date -j -f "%s" $LAST_APPLY)
if [ $(date -v -7d +"%s") -ge $LAST_APPLY ]; then
  while true; do
    echo "Run 'chezmoi apply' (last apply: $LAST_APPLY_READABLE)? Y/n"; read -sk yn
    case $yn in
      [Nn]* ) 
        break
        ;;
      [Yy]* )
        chezmoi apply
        break
        ;;
      * )
        if [[ $yn == $'\n' ]]; then # TODO is there a neater way to case check for \n
          chezmoi apply
          break
        fi
        ;;
    esac
  done
fi
