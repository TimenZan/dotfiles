#!/usr/bin/env sh

url=$(cat ~/secrets/backblaze_duplicity)

duplicity "$@" "$url"

