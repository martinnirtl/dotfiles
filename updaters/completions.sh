#! /bin/bash

source "$(dirname "$0")/helpers/utils.sh"

cat << EOF

░█▀▀░█▀█░█▄█░█▀█░█░░░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
░█░░░█░█░█░█░█▀▀░█░░░█▀▀░░█░░░█░░█░█░█░█░▀▀█
░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

EOF

exit_on_disabled "$0"

prompt_to_continue "Update custom completions?"

CUSTOM_COMPLETIONS="$(chezmoi source-path)/dot_config/custom_completions"

if [[ -z "$COMPLETIONS" ]]; then
    echo "COMPLETIONS variable not set. Exitting..."
    exit 1
fi

if [ ! -d "$COMPLETIONS" ]; then
	echo "Directory does not exist. Exitting..."
      exit 1
fi

while IFS= read -r binary_name; do
    # Skip empty lines
    if [[ -z "$binary_name" ]]; then
        continue
    fi

    # Execute the command with the binary name
    "$binary_name" completion zsh > $COMPLETIONS/_$binary_name
done < "$CUSTOM_COMPLETIONS"