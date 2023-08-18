#!/bin/bash

# Create a temp file to store dependencies
tempfile=$(mktemp)

# Build a list of all dependencies for installed formulas
for pkg in $(brew list 2>&1); do
    for dep in $(brew deps --include-build $pkg 2>&1); do
        echo "$dep:$pkg" >> "$tempfile"
    done
done

find_reverse_deps() {
    local formula=$1
    local dependents=()

    while IFS=: read -r dep pkg; do
        if [[ "$dep" == "$formula" ]]; then
            dependents+=("$pkg")
        fi
    done < "$tempfile"

    if [ ${#dependents[@]} -ne 0 ]; then
        echo "$formula is a dependency for:"
        for dependent in "${dependents[@]}"; do
            echo "  - $dependent"
        done
        echo ""
    else
        echo "$formula has no dependents."
        echo ""
    fi
}

# Check each argument passed to the script
for arg in "$@"; do
    find_reverse_deps "$arg"
done

# Cleanup temp file
rm "$tempfile"
