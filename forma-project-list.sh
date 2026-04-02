#!/bin/bash

cd ~/dev/forma || exit

printf "[\n"
for dir in */; do
  name="${dir%/}"
  printf '  { "title": "%s", "value": "%s" },\n' "$name" "$name"
done | sed '$ s/},$/}/'
printf "]\n"

