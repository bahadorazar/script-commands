#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title gmail
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 📫

# Documentation:
# @raycast.description Open Gmail
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Profile 1" "https://gmail.com/"

