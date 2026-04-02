#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title chat
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 💬

# Documentation:
# @raycast.description Open ChatGPT
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Profile 1" "https://chat.openai.com/"

