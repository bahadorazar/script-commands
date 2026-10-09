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
# @raycast.argument2 { "type": "dropdown", "optional": true, "placeholder": "Select a premade prompt (optional)", "default": "__NONE__", "data": [{"title": "None", "value": "__NONE__"}, {"title": "Professional chill", "value": "Rewrite this text in professional chill language. Make it concise and keep all important information. It should be easy to read and understand."}, {"title": "Concise", "value": "Make it concise and keep all important information. It should be easy to read and understand. Do not change the tone of the text."}, {"title": "Proofread", "value": "Proofread this text for any grammar and spelling errors. Remove any ambiguity from the text. Do not change the tone of the text."}, {"title": "Define", "value": "Define the following word or expression in US English (use the same format as you'd get from typeing `define <word>` in google, most common use cases and examples). Also give natural equivalent of the word in Persian."}, {"title": "English to Norwegian", "value": "Write the following in natural Norwegian. Do not use uncommon phrases or words. Use common words and phrases."}, {"title": "Norwegian to English", "value": "What is the meaning of the following Norwegian text in English: "}] }
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