#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title gh
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 😼
# @raycast.argument1 { "type": "text", "placeholder": "Repo" }

# Documentation:
# @raycast.description Search repos in SpacemakerAI GitHub org
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
open -na "Google Chrome" --args --profile-directory="Default" "https://github.com/orgs/spacemakerai/repositories?type=all&q=$query"

