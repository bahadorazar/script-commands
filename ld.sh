#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title LaunchDarkly
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🚦

# Documentation:
# @raycast.description Open LaunchDarkly for spacemkr_web
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://app.launchdarkly.com/projects/spacemkr_web/flags?env=development&env=production&env=production&selected-env=production"

