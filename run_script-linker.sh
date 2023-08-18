#!/bin/bash

echo "Linking scripts..."

# Source directory holding the scripts
SOURCE_DIR="$(chezmoi source-path)/scripts"

# Destination directory for the symbolic links
DEST_DIR="$DEV_TOOLS/bin"

# Check if directories exist
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Source directory doesn't exist!"
    exit 1
fi

if [[ ! -d "$DEST_DIR" ]]; then
    echo "Destination directory doesn't exist!"
    exit 1
fi

# Function to process each file from the source directory
process_script() {
    local script="$1"
    local script_name=$(basename "$script")
    local link_target="$DEST_DIR/$script_name"

    # Check if there's already a symbolic link at the destination
    if [[ -L "$link_target" ]]; then
        # If the link is broken, remove it
        if [[ ! -e "$link_target" ]]; then
            rm "$link_target"
            echo "Removed broken link for $script_name"
        else
            # If the link is valid, skip the current iteration
            echo "$script_name already has a valid link. Skipping..."
            return
        fi
    fi

    # Create a symbolic link for the script
    ln -s "$script" "$link_target"
    echo "Created symbolic link for $script_name"
}

# Iterate through the files in the source directory (not checking for extensions)
for script in "$SOURCE_DIR"/*; do
    # Ensure it's a file and not a directory or symlink
    if [[ -f "$script" && ! -L "$script" ]]; then
        process_script "$script"
    fi
done

echo
