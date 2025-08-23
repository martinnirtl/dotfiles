#!/bin/bash

source "$CHEZMOI_SOURCE_DIR/updaters/helpers/utils.sh"

prompt_to_continue "Run updater?"

# Directory holding the scripts
SCRIPTS_DIR="$CHEZMOI_SOURCE_DIR/updaters"

# Loop over all .sh files in the specified directory and execute them
for script in "$SCRIPTS_DIR"/*.sh; do
    if [[ -f "$script" ]]; then
        echo "> $(basename ${script})"
        bash "$script"  # or sh "$script", depending on your preference
        echo ""
    fi
done
