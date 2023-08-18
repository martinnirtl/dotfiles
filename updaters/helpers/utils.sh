#! /bin/bash

require_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run with sudo."
        exit 1
    fi
}

prompt_to_continue() {
    local question="$1"
    local default_answer="$2"
    local exit_code="$3"
    local exit_message="$4"

    # Prompt user with a timeout and wait for a single character input or Enter key
    read -t 10 -n 1 -p "$question (${default_answer^^}/n) " answer
    echo ""  # Move to a new line after the input

    # If answer is empty (due to timeout or Enter key), set it to the default answer
    if [[ -z "$answer" ]]; then
        answer="$default_answer"
    fi

    # Check the answer and act accordingly
    if [[ $answer == "n" || $answer == "N" ]]; then
        echo "$exit_message"
        exit "$exit_code"
    fi
}
