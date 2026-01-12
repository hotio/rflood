#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/rakshasa/rtorrent/releases/latest" | jq -re .tag_name)
flood_version=$(curl -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -re .tag_name)
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg flood_version "${flood_version//v/}" \
    '.version = $version | .flood_version = $flood_version' <<< "${json}" | tee meta.json
