#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Glean
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🔎
# @raycast.argument1 { "type": "text", "placeholder": "Search Autodesk" }

# Documentation:
# @raycast.description Glean Search
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
open -na "Google Chrome" --args --profile-directory="Default" "https://app.glean.com/search?q=$query"