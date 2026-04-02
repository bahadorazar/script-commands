#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Autodesk ONE
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🅰️

# Documentation:
# @raycast.description Open Autodesk ONE homepage
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://one.autodesk.com"

