#!/bin/bash

# Script to sync premade prompts from JSON to both gpt.sh and tempgpt.sh
# Run this script after editing premade-prompts.json to update the dropdown metadata

PROMPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$(cd "${PROMPTS_DIR}/.." && pwd)"
JSON_FILE="${PROMPTS_DIR}/premade-prompts.json"
GPT_SCRIPT="${SCRIPT_DIR}/gpt.sh"
TEMPGPT_SCRIPT="${SCRIPT_DIR}/tempgpt.sh"

# Generate dropdown data from JSON
export JSON_FILE
DROPDOWN_DATA=$(python3 << 'PYTHON_EOF'
import json
import os

json_file = os.environ.get('JSON_FILE')
with open(json_file, 'r') as f:
    prompts = json.load(f)

# Generate the dropdown data format for Raycast
dropdown_items = []
for item in prompts:
    title = json.dumps(item['title'])[1:-1]  # Remove outer quotes
    value = json.dumps(item['value'])[1:-1]  # Remove outer quotes, properly escaped
    dropdown_items.append(f'{{"title": "{title}", "value": "{value}"}}')

dropdown_data = ', '.join(dropdown_items)
print(f'[{dropdown_data}]')
PYTHON_EOF
)

# Function to update dropdown in a script file
update_script() {
    local script_file="$1"
    local temp_file=$(mktemp)
    
    # Use sed to replace the dropdown data line
    sed "s|@raycast.argument2.*|@raycast.argument2 { \"type\": \"dropdown\", \"optional\": true, \"placeholder\": \"Select a premade prompt (optional)\", \"default\": \"__NONE__\", \"data\": ${DROPDOWN_DATA} }|" "$script_file" > "$temp_file"
    mv "$temp_file" "$script_file"
}

# Update both scripts
echo "Syncing prompts to gpt.sh..."
update_script "$GPT_SCRIPT"

echo "Syncing prompts to tempgpt.sh..."
update_script "$TEMPGPT_SCRIPT"

echo "Done! Both scripts have been updated with prompts from prompts/premade-prompts.json"

