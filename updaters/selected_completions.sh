#! /bin/bash

source "$(dirname "$0")/helpers/utils.sh"

lolcat << EOF

░█▀▀░█▀█░█▄█░█▀█░█░░░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
░█░░░█░█░█░█░█▀▀░█░░░█▀▀░░█░░░█░░█░█░█░█░▀▀█
░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

EOF

CUSTOM_COMPLETIONS="$CHEZMOI_SOURCE_DIR/dot_config/custom_completions"

if [[ -z "$COMPLETIONS" ]]; then
    echo "COMPLETIONS variable not set. Exitting..."
    exit 1
fi

# if [ ! -d "$COMPLETIONS" ]; then
# 	echo "Directory does not exist. Creating ${COMPLETIONS}"
#     mkdir -p $COMPLETIONS
# fi

echo "Recreating completions..."
rm -rf $COMPLETIONS
mkdir -p $COMPLETIONS
echo

while IFS= read -r binary_name; do
    # Skip empty lines
    if [[ -z "$binary_name" ]]; then
        continue
    fi

    # Execute the command with the binary name
    echo "Generating completion: $binary_name"
    "$binary_name" completion zsh > $COMPLETIONS/_$binary_name
done < "$CUSTOM_COMPLETIONS"
