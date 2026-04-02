#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title who
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🕵️
# @raycast.argument1 { "type": "text", "placeholder": "Name" }

# Documentation:
# @raycast.description Search Aware
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
open -na "Google Chrome" --args --profile-directory="Default" "https://aware.autodesk.com/?q=$query"

