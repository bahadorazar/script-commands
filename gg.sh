#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Google
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🔎
# @raycast.argument1 { "type": "text", "placeholder": "search Google" }

# Documentation:
# @raycast.description Google Search
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
open -na "Google Chrome" --args --profile-directory="Profile 1" "https://www.google.com/search?q=$query"