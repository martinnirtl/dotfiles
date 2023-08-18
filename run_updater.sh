#!/bin/bash

# directory holding the scripts
SCRIPT_DIR="$(chezmoi source-path)/updaters"

# # get a list of all bash scripts in the directory
# scripts=($(ls $SCRIPT_DIR/*.sh))

# # function to display scripts and get user input
# select_scripts_to_skip() {
#     echo "Select the scripts you want to skip (e.g., 1 3 5):"
#     for ((i=0; i<${#scripts[@]}; i++)); do
#         echo "$((i+1)). $(basename ${scripts[$i]})"
#     done

#     read -a skipped_indices
# }
# echo ""

# # get user input
# select_scripts_to_skip

# # execute the scripts that weren't skipped with sudo
# for ((i=0; i<${#scripts[@]}; i++)); do
#     # check if current script index is in the list of skipped indices
#     if ! [[ " ${skipped_indices[@]} " =~ " $((i+1)) " ]]; then
#         echo ""
#         echo "Running $(basename ${scripts[$i]})..."
#         bash "${scripts[$i]}"
#         echo ""
#     else
#         echo "Skipping $(basename ${scripts[$i]})"
#     fi
# done

# Loop over all .sh files in the specified directory and execute them
for script in "$SCRIPT_DIR"/*.sh; do
    if [[ -f "$script" ]]; then
        echo "> $(basename ${script})"
        bash "$script"  # or sh "$script", depending on your preference
        echo ""
    fi
done
