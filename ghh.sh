#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ghh
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🐱
# @raycast.keyword ghh

# Documentation:
# @raycast.description Open the SpacemakerAI organization page on GitHub
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://github.com/spacemakerai/"

