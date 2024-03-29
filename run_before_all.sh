#! /bin/bash

cat << EOF

      ___           ___           ___           ___           ___           ___                 
     /\  \         /\__\         /\  \         /\  \         /\__\         /\  \          ___   
    /::\  \       /:/  /        /::\  \        \:\  \       /::|  |       /::\  \        /\  \  
   /:/\:\  \     /:/__/        /:/\:\  \        \:\  \     /:|:|  |      /:/\:\  \       \:\  \ 
  /:/  \:\  \   /::\  \ ___   /::\~\:\  \        \:\  \   /:/|:|__|__   /:/  \:\  \      /::\__\\
 /:/__/ \:\__\ /:/\:\  /\__\ /:/\:\ \:\__\ _______\:\__\ /:/ |::::\__\ /:/__/ \:\__\  __/:/\/__/
 \:\  \  \/__/ \/__\:\/:/  / \:\~\:\ \/__/ \::::::::/__/ \/__/~~/:/  / \:\  \ /:/  / /\/:/  /   
  \:\  \            \::/  /   \:\ \:\__\    \:\~~\~~           /:/  /   \:\  /:/  /  \::/__/    
   \:\  \           /:/  /     \:\ \/__/     \:\  \           /:/  /     \:\/:/  /    \:\__\    
    \:\__\         /:/  /       \:\__\        \:\__\         /:/  /       \::/  /      \/__/    
     \/__/         \/__/         \/__/         \/__/         \/__/         \/__/                

EOF

echo
echo "Running 'chezmoi apply'..."
echo

# NOTE: Chezmoi apply checker checks against last_modified date of file, not the content itself
cat << EOF > .config/chezmoi_last-apply.txt
PLEASE DO NOT EDIT THIS FILE MANUALLY

LAST RUN:  $(date)
EOF