#!/usr/bin/env bash

source ./utils/bash_colors

# Bash version check for mapfile (Bash >= 4.0 required)
if ((BASH_VERSINFO[0] < 4)); then
    log red "This script requires Bash 4.0 or newer (for 'mapfile' support)."
    log cyan "You're running Bash version: $BASH_VERSION"
    log cyan "On macOS, install a newer Bash with:"
    log green "  brew install bash"
    log cyan "Then run the script as:"
    log green "  /usr/local/bin/bash $0"
    exit 1
fi

# Check for gum (interactive selector)
if ! command -v gum >/dev/null 2>&1; then
    log red "gum is required for this script. Install it with: brew install gum"
    exit 1
fi

# Ensure the script is running in a real terminal (TTY)
if [[ ! -t 0 ]]; then
    log red "This script must be run in a terminal (TTY) for interactive selection."
    exit 1
fi

CHEZMOI_SOURCE_DIR="${CHEZMOI_SOURCE_DIR:-$HOME/.local/share/chezmoi}"
SCRIPTS_DIR="$CHEZMOI_SOURCE_DIR/updaters"

# --- Gather all .sh scripts, storing metadata for each ---
scripts=()          # Full filename (with .sh)
scripts_display=()  # Name shown in gum (no .sh, no prefixes)
# is_sudo=()          # 1 if needs sudo, 0 otherwise
is_selected=()      # 1 if preselected, 0 otherwise

while IFS= read -r -d '' file; do
    base=$(basename "$file")
    display_name="${base%.sh}"
    # Remove all leading (possibly repeated) prefixes in any order
    while [[ "$display_name" == sudo_* || "$display_name" == selected_* ]]; do
        display_name="${display_name#sudo_}"
        display_name="${display_name#selected_}"
    done

    # Detect if sudo or selected is present anywhere in the prefix chain
    temp_name="${base%.sh}"
    sudo_flag=0
    selected_flag=0
    [[ "$temp_name" =~ (^|_)sudo_ ]] && sudo_flag=1
    [[ "$temp_name" =~ (^|_)selected_ ]] && selected_flag=1

    scripts+=("$base")
    scripts_display+=("$display_name")
    # is_sudo+=("$sudo_flag")
    is_selected+=("$selected_flag")
done < <(find "$SCRIPTS_DIR" -type f -name "*.sh" -not -name ".*" -print0 | sort -z)

if [[ ${#scripts[@]} -eq 0 ]]; then
    log red "No scripts found in $SCRIPTS_DIR."
    exit 1
fi

# --- Preselect only 'selected_' scripts in gum (using display names) ---
preselect_names=()
for idx in "${!scripts[@]}"; do
    if [[ "${is_selected[$idx]}" -eq 1 ]]; then
        preselect_names+=("${scripts_display[$idx]}")
    fi
done

# Prepare --selected arguments (one for each name)
selected_args=()
for name in "${preselect_names[@]}"; do
    selected_args+=(--selected "$name")
done

# --- If any sudo scripts, prompt for sudo upfront ---
# any_sudo=0
# for flag in "${is_sudo[@]}"; do
#     if [[ "$flag" -eq 1 ]]; then
#         any_sudo=1
#         break
#     fi
# done

# if [[ "$any_sudo" -eq 1 ]]; then
#     log yellow "Some scripts require sudo. Please enter your password if prompted."
#     sudo -v || { log red "Sudo authentication failed."; exit 1; }
# fi

# --- Use gum for interactive multi-selection ---
mapfile -t selected < <(
    printf "%s\n" "${scripts_display[@]}" |
        gum choose --no-limit --ordered --height=20 --timeout="20s" \
        --cursor="➤" --cursor.foreground="51" \
        --header.foreground="51" --item.foreground="242" --selected.foreground="15" \
        "${selected_args[@]}" \
        --header="SPACE to toggle, ENTER to confirm. PRESELECTED scripts with 'selected_' in filename."
)

if [[ ${#selected[@]} -eq 0 ]]; then
    log cyan "No scripts selected. Exiting."
    exit 0
fi

log green "Running selected scripts..."
echo

for chosen in "${selected[@]}"; do
    for i in "${!scripts_display[@]}"; do
        if [[ "${scripts_display[$i]}" == "$chosen" ]]; then
            script_path="$SCRIPTS_DIR/${scripts[$i]}"
            if [[ -f "$script_path" ]]; then
                # if [[ "${is_sudo[$i]}" -eq 1 ]]; then
                #     log cyan "sudo > ${scripts[$i]}"
                #     sudo bash "$script_path"
                # else
                #     log cyan "> ${scripts[$i]}"
                #     bash "$script_path"
                # fi
                log cyan "> ${scripts[$i]}"
                bash "$script_path"
                echo ""
            else
                log red "Not found: ${scripts[$i]}"
            fi
        fi
    done
done