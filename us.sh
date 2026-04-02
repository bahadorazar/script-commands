#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title us
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🇺🇸

# Documentation:
# @raycast.description Open Forma App US
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://app.autodeskforma.com/app-home"

