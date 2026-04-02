#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title c
# @raycast.mode silent
# @raycast.packageName Development

# Optional parameters:
# @raycast.icon 🧊
# @raycast.argument1 { "type": "text", "placeholder": "Project name" }

# Documentation:
# @raycast.description Open best-matching Forma project in Cursor using non-interactive fzf
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

cd "$HOME/dev/forma" || exit 1

# Get best match using fzf non-interactively
best_match=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|^\./||' | fzf -f "$1" --select-1 --exit-0 | head -n 1)

if [ -n "$best_match" ]; then
  open -a "Cursor" "$HOME/dev/forma/$best_match"
else
  osascript -e 'display notification "No matching project found" with title "Cursor Launcher"'
fi

