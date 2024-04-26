#!/bin/bash
rtorrent_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/rtorrent/releases/latest" | jq -re .tag_name) || exit 1
[[ -z ${rtorrent_version} ]] && exit 0
[[ ${rtorrent_version} == null ]] && exit 0
flood_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -re .tag_name) || exit 1
[[ -z ${flood_version} ]] && exit 0
[[ ${flood_version} == null ]] && exit 0
version="${rtorrent_version}--${flood_version}"
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg flood_version "${flood_version//v/}" \
    --arg rtorrent_version "${rtorrent_version//v/}" \
    '.version = $version | .flood_version = $flood_version | .rtorrent_version = $rtorrent_version' <<< "${json}" | tee VERSION.json
