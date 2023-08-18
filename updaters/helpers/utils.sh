#!/bin/bash

require_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run with sudo."
        exit 1
    fi
}

prompt_to_continue_options() {
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

prompt_to_continue() {
    local question="$1"

    read -t 10 -n 1 -s -r -p "$question [Enter] to continue or any other key to cancel"

    if [[ $REPLY != "" ]]; then
        echo " > cancelled"
        exit 0
    fi

    echo ""  # Move to a new line for better readability
}

exit_on_disabled() {
    local script_name=$(basename "$1")
    local script_name_without_extension="${script_name%.*}"
    local var_name=$(echo "DISABLE_UPDATER_$script_name_without_extension" | tr 'a-z' 'A-Z')
    
    # Retrieve the value of the environment variable
    local value="${!var_name}"
    
    # Check if the value is truthy (set and not empty)
    if [[ -n "$value" ]]; then
        echo "Updater disabled: Variable $var_name is set to: $value"
        exit 0
    fi
}
