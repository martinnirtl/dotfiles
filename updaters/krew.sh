#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█░█░█▀▄░█▀▀░█░█
░█▀▄░█▀▄░█▀▀░█▄█
░▀░▀░▀░▀░▀▀▀░▀░▀

EOF

exit_on_disabled "$0"

if [[ ! -d "$HOME/.krew" ]]; then
    echo "Please verify installation of Krew! Exitting..."
    exit 1
fi

prompt_to_continue "Update Krew plugins?"

kubectl-krew update
kubectl-krew upgrade

echo ""
echo "Don't forget to backup Krew plugins..."
