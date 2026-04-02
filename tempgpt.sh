#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title tmpgpt
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Enter your prompt" }
# Premade prompts are defined in prompts/premade-prompts.json - run prompts/sync-prompts.sh after editing
# @raycast.argument2 { "type": "dropdown", "optional": true, "placeholder": "Select a premade prompt (optional)", "default": "__NONE__", "data": [{"title": "None", "value": "__NONE__"}, {"title": "Write professionally", "value": "Rewrite this text in professional chill language. "}, {"title": "Make it concise", "value": "Make this text more concise while keeping all important information: "}, {"title": "Fix grammar", "value": "Fix any grammar and spelling errors in this text: "}, {"title": "Explain to dev", "value": "Explain this to a junior developer: "}, {"title": "English to Norwegian", "value": "Write the following in natural Norwegian. Do not use uncommon phrases or words. Use common words and phrases."}, {"title": "Norwegian to English", "value": "What is the meaning of the following Norwegian text in English: "}] }
# @raycast.argument3 { "type": "text", "placeholder": "Additional context (optional)", "optional": true }

# Documentation:
# @raycast.description Open ChatGPT with your prompt
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

USER_PROMPT="$1"
PREMADE_PROMPT="$2"
CONTEXT="$3"

# Treat "__NONE__" as empty (for Raycast dropdown "None" option)
if [ "$PREMADE_PROMPT" = "__NONE__" ]; then
    PREMADE_PROMPT=""
fi

# Build the prompt: premade prompt (if any) + user prompt + two newlines + context (if any)
if [ -n "$PREMADE_PROMPT" ]; then
    # Remove trailing spaces from premade prompt and add quoted user prompt
    PROMPT="${PREMADE_PROMPT%"${PREMADE_PROMPT##*[![:space:]]}"}
\"${USER_PROMPT}\""
else
    PROMPT="${USER_PROMPT}"
fi

# Add context two lines below if provided
if [ -n "$CONTEXT" ]; then
    PROMPT="${PROMPT}


${CONTEXT}"
fi

# URL encode the prompt using python3 (standard on macOS)
ENCODED_PROMPT=$(python3 -c "import urllib.parse; import sys; print(urllib.parse.quote(sys.argv[1]))" "$PROMPT")

# Open ChatGPT in Chrome with the prompt parameter (q= auto-executes the prompt)
open -na "Google Chrome" --args --profile-directory="Default" "https://chatgpt.com/?q=${ENCODED_PROMPT}&temporary-chat=true"