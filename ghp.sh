#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ghp
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🔀

# Documentation:
# @raycast.description View GitHub Pull Requests
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://github.com/pulls"

