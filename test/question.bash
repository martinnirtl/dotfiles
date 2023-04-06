#! /bin/bash

echo "Hit it! Y/n"
while true; do
  read -sn 1 yn
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
      if [ -z ${yn} ]; then # TODO is there a neater way to case check for \n
        echo "default"
        break
      else
        echo "INVALID - NO ACTION: $yn"
      fi
      ;;
  esac
done