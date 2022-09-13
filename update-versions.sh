#!/bin/bash

rtorrent_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/rtorrent/releases/latest" | jq -r .tag_name | sed s/v//g)
[[ -z ${rtorrent_version} ]] && exit 0
flood_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -r .tag_name | sed s/v//g)
[[ -z ${flood_version} ]] && exit 0
version="${rtorrent_version}--${flood_version}"
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .flood_version = "'"${flood_version}"'" | .rtorrent_version = "'"${rtorrent_version}"'"' <<< "${version_json}" > VERSION.json
