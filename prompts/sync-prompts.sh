#!/bin/bash

# Script to sync premade prompts from JSON to both gpt.sh and tempgpt.sh
# Run this script after editing premade-prompts.json to update the dropdown metadata

PROMPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$(cd "${PROMPTS_DIR}/.." && pwd)"
JSON_FILE="${PROMPTS_DIR}/premade-prompts.json"
GPT_SCRIPT="${SCRIPT_DIR}/gpt.sh"
TEMPGPT_SCRIPT="${SCRIPT_DIR}/tempgpt.sh"

export JSON_FILE GPT_SCRIPT TEMPGPT_SCRIPT
python3 << 'PYTHON_EOF'
import json
import os

json_file = os.environ["JSON_FILE"]
gpt_script = os.environ["GPT_SCRIPT"]
tempgpt_script = os.environ["TEMPGPT_SCRIPT"]

with open(json_file, "r", encoding="utf-8") as f:
    prompts = json.load(f)

data_items = []
inserted_standalone_header = False
for item in prompts:
    title = item["title"]
    value = item["value"]
    if item.get("standalone"):
        if not inserted_standalone_header:
            data_items.append({"title": "— No input needed —", "value": "__SEPARATOR__"})
            inserted_standalone_header = True
        title = f"⚡ {title}"
        value = f"__STANDALONE__:{value}"
    data_items.append({"title": title, "value": value})

argument2 = {
    "type": "dropdown",
    "optional": True,
    "placeholder": "Select a premade prompt (optional)",
    "default": "__NONE__",
    "data": data_items,
}
argument2_json = json.dumps(argument2, ensure_ascii=False)
# Raycast expects a space after "{" (same as other @raycast.argument lines)
argument2_line = f"# @raycast.argument2 {{ {argument2_json[1:].lstrip()}\n"


def update_script(script_path: str) -> None:
    with open(script_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    new_lines = []
    skipping_broken_argument2 = False
    for line in lines:
        if line.startswith("# @raycast.argument2"):
            new_lines.append(argument2_line)
            skipping_broken_argument2 = True
            continue
        if skipping_broken_argument2:
            if line.startswith("# @raycast.argument3"):
                skipping_broken_argument2 = False
                new_lines.append(line)
            continue
        new_lines.append(line)

    with open(script_path, "w", encoding="utf-8") as f:
        f.writelines(new_lines)


for path in (gpt_script, tempgpt_script):
    update_script(path)
    print(f"Synced {path}")
PYTHON_EOF

echo "Done! Both scripts have been updated with prompts from prompts/premade-prompts.json"
