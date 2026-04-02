#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DataDog
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🐶

# Documentation:
# @raycast.description Open Datadog Logs
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

open -na "Google Chrome" --args --profile-directory="Default" "https://app.datadoghq.eu/logs"

