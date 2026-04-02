#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wiki
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 📚
# @raycast.argument1 { "type": "text", "placeholder": "Search query", "optional": true }

# Documentation:
# @raycast.description Search Atlassian Wiki
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

if [ -n "$1" ]; then
  query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
  open -na "Google Chrome" --args --profile-directory="Default" "https://autodesk.atlassian.net/wiki/search?text=${query}"
else
  open -na "Google Chrome" --args --profile-directory="Default" "https://autodesk.atlassian.net/wiki/home"
fi
