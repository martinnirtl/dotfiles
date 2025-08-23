#!/bin/bash

source "$(dirname "$0")/helpers/utils.sh"

lolcat << EOF

░█░█░█▀▄░█▀▀░█░█
░█▀▄░█▀▄░█▀▀░█▄█
░▀░▀░▀░▀░▀▀▀░▀░▀

EOF

if [[ ! -d "$HOME/.krew" ]]; then
    echo "Please verify installation of Krew! Exitting..."
    exit 1
fi

kubectl-krew update
kubectl-krew upgrade

# file2="$CHEZMOI_SOURCE/kubectl-plugins.txt"
# # Ensure the files exist
# if [[ ! -f "$file2" ]]; then
#     echo "One or both files do not exist!"
#     exit 1
# fi

# file1=$(mktemp)
# kubectl-krew list > $file1

# # # Sort the files in-place (needed for 'comm')
# # sort "$file1" -o "$file1"
# # sort "$file2" -o "$file2"

# rm $file1

echo ""
echo "Don't forget to backup Krew plugins via 'scripts_backup-xrew'"
