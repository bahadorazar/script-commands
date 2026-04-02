#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title aus
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🇦🇺

# Documentation:
# @raycast.description Open Forma App AUS
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://forma.aus.autodesk.com/app-home"

