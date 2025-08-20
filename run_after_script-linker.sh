#!/bin/bash

echo "Linking scripts..."

# Source directory holding the scripts
SOURCE_DIR="$CHEZMOI_SOURCE_DIR/scripts"

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

verify_symlinks() {
    local dir_path="$1"

    if [[ ! -d "$dir_path" ]]; then
        echo "The given path is not a directory!"
        return 1
    fi

    # Find all symbolic links in the directory
    find "$dir_path" -type l | while IFS= read -r symlink; do
        # Check if the target of the symlink exists
        if [[ ! -e "$symlink" ]]; then
            echo "Removing broken symlink: $symlink"
            rm $symlink
        fi
    done
}

verify_symlinks $DEST_DIR

# Function to process each file from the source directory
create_symlink() {
    local script="$1"
    local script_name=$(basename "$script")
    local link_target="$DEST_DIR/$script_name"

    # Check if there's already a symbolic link at the destination
    if [[ -L "$link_target" ]]; then
        # If the link is broken, remove it
        if [[ -e "$link_target" ]]; then
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
        create_symlink "$script"
    fi
done

echo
