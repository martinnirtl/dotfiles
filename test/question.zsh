#! /opt/homebrew/bin/zsh

echo "Hit it! Y/n"
while true; do
  read -sk yn
  case $yn in
    [Nn]* )
      echo "NO via $yn"
      break
      ;;
    [Yy]* )
      echo "YES via $yn"
      break
      ;;
    * )
      if [[ $yn == $'\n' ]]; then
        echo "default"
        break
      else
        echo "INVALID - NO ACTION"
      fi
      ;;
  esac
done