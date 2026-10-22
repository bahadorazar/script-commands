#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title gpt
# @raycast.mode silent
# @raycast.packageName Chrome

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Enter your prompt", "optional": true }
# Premade prompts are defined in prompts/premade-prompts.json - run prompts/sync-prompts.sh after editing
# @raycast.argument2 { "type": "dropdown", "optional": true, "placeholder": "Select a premade prompt (optional)", "default": "__NONE__", "data": [{"title": "None", "value": "__NONE__"}, {"title": "Professional chill", "value": "Rewrite this text in professional chill language. Make it concise and keep all important information. It should be easy to read and understand."}, {"title": "Concise", "value": "Make it concise and keep all important information. It should be easy to read and understand. Do not change the tone of the text."}, {"title": "Proofread", "value": "Proofread this text for any grammar and spelling errors. Remove any ambiguity from the text. Do not change the tone of the text."}, {"title": "Define", "value": "Define the following word or expression in US English. Cover the most common meaning and typical usage.\n\nWrite the answer in Markdown using exactly this structure every time (same headings, order, and formatting; no text before or after):\n\n# {term}\n\n{part of speech} · {register/style tags as needed, e.g. informal, formal, humorous, business; separated by ·}\n\nPronunciation: /{IPA}/ (US)\n\nDefinition: {full definition}\n\nIn simple terms: {plain-language paraphrase}\n\n### Persian equivalents\n\n- {Persian phrase}: {when to use it}\n(3–5 bullets)\n\n### Common uses and examples\n\n1\\. {short use-case label}\n\n\"{natural English example}\"\n\n«{natural Persian translation}»\n\n(Repeat for 3–4 numbered uses; keep the same pattern: escaped number, label, blank line, English in quotes, Persian in guillemets.)\n\n### Synonyms\n\n| Word | Nuance |\n| --- | --- |\n| {word} | {nuance} |\n(5–7 rows)\n\n### Usage notes\n\n{When it sounds natural, register, and typical contexts.}\n\nIt often appears in these constructions:\n\n- \"{common phrase}\"\n(2–3 bullets)\n\nKey distinction: {vs the nearest simpler word or near-synonym.}\n\nClosest natural Persian equivalent: «{phrase}»"}, {"title": "English to Norwegian", "value": "Write the following in natural Norwegian. Do not use uncommon phrases or words. Use common words and phrases."}, {"title": "Norwegian to English", "value": "What is the meaning of the following Norwegian text in English: "}, {"title": "— No input needed —", "value": "__SEPARATOR__"}, {"title": "⚡ Word of the day", "value": "__STANDALONE__:Pick one interesting American English word or common expression at CEFR B2–C1 that I might not know: something natives use often but non-natives usually replace with simpler wording. It should sound natural in business or casual conversation, not pretentious or jargony.\n\nWrite the answer in Markdown using exactly this structure every time (same headings, order, and formatting; no text before or after):\n\n# {term}\n\n{part of speech} · {register/style tags as needed, e.g. informal, formal, humorous, business; separated by ·}\n\nPronunciation: /{IPA}/ (US)\n\nDefinition: {full definition}\n\nIn simple terms: {plain-language paraphrase}\n\n### Persian equivalents\n\n- {Persian phrase}: {when to use it}\n(3–5 bullets)\n\n### Common uses and examples\n\n1\\. {short use-case label}\n\n\"{natural English example}\"\n\n«{natural Persian translation}»\n\n(Repeat for 3–4 numbered uses; keep the same pattern: escaped number, label, blank line, English in quotes, Persian in guillemets.)\n\n### Synonyms\n\n| Word | Nuance |\n| --- | --- |\n| {word} | {nuance} |\n(5–7 rows)\n\n### Usage notes\n\n{When it sounds natural, register, and typical contexts.}\n\nIt often appears in these constructions:\n\n- \"{common phrase}\"\n(2–3 bullets)\n\nKey distinction: {vs the nearest simpler word or near-synonym.}\n\nClosest natural Persian equivalent: «{phrase}»"}]}
# @raycast.argument3 { "type": "text", "placeholder": "Additional context (optional)", "optional": true }

# Documentation:
# @raycast.description Open ChatGPT with your prompt
# @raycast.author Bahador Azar
# @raycast.authorURL https://github.com/spacemakerai

USER_PROMPT="$1"
PREMADE_PROMPT="$2"
CONTEXT="$3"

# Treat dropdown sentinels as empty
if [ "$PREMADE_PROMPT" = "__NONE__" ] || [ "$PREMADE_PROMPT" = "__SEPARATOR__" ]; then
    PREMADE_PROMPT=""
fi

# Standalone premade prompts: use as-is (no user text or context)
if [[ "$PREMADE_PROMPT" == __STANDALONE__:* ]]; then
    PROMPT="${PREMADE_PROMPT#__STANDALONE__:}"
    PROMPT="${PROMPT%"${PROMPT##*[![:space:]]}"}"
    ENCODED_PROMPT=$(python3 -c "import urllib.parse; import sys; print(urllib.parse.quote(sys.argv[1]))" "$PROMPT")
    open -na "Google Chrome" --args --profile-directory="Default" "https://chatgpt.com/?q=${ENCODED_PROMPT}"
    exit 0
fi

# Build the prompt: premade prompt (if any) + user prompt + two newlines + context (if any)
PROMPT=""

# Add premade prompt if provided
if [ -n "$PREMADE_PROMPT" ]; then
    # Remove trailing spaces from premade prompt
    PROMPT="${PREMADE_PROMPT%"${PREMADE_PROMPT##*[![:space:]]}"}"
fi

# Add user prompt if provided
if [ -n "$USER_PROMPT" ]; then
    if [ -n "$PREMADE_PROMPT" ]; then
        # Add quotes around user prompt if premade prompt exists
        if [ -n "$PROMPT" ]; then
            PROMPT="${PROMPT}
\"${USER_PROMPT}\""
        else
            PROMPT="\"${USER_PROMPT}\""
        fi
    else
        # Don't add quotes if no premade prompt
        if [ -n "$PROMPT" ]; then
            PROMPT="${PROMPT}
${USER_PROMPT}"
        else
            PROMPT="${USER_PROMPT}"
        fi
    fi
fi

# Add context two lines below user prompt if provided
if [ -n "$CONTEXT" ]; then
    if [ -n "$PROMPT" ]; then
        PROMPT="${PROMPT}


${CONTEXT}"
    else
        PROMPT="${CONTEXT}"
    fi
fi

# URL encode the prompt using python3 (standard on macOS)
ENCODED_PROMPT=$(python3 -c "import urllib.parse; import sys; print(urllib.parse.quote(sys.argv[1]))" "$PROMPT")

# Open ChatGPT in Chrome with the prompt parameter (q= auto-executes the prompt)
open -na "Google Chrome" --args --profile-directory="Default" "https://chatgpt.com/?q=${ENCODED_PROMPT}"
