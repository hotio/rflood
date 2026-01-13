#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/rakshasa/rtorrent/releases/latest" | jq -re .tag_name)
version_flood=$(curl -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -re .tag_name)
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg version_flood "${version_flood//v/}" \
    '.version = $version | .version_flood = $version_flood' <<< "${json}" | tee meta.json
