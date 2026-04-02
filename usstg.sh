#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title usstg
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🧪

# Documentation:
# @raycast.description Open Staging App US
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://forma.stg.usa.autodesk.com/app-home"

