#!/usr/bin/env bash
set -euo pipefail

usage() {
    printf 'Usage: %s <map.json|directory-containing-map.json>\n' "${0##*/}"
    printf 'Generate keymap.svg beside the source map.json. Requires keymap-drawer (keymap on PATH).\n'
}

if [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]]; then
    usage
    exit 0
fi

if [[ $# -ne 1 ]]; then
    printf 'Error: expected exactly one map.json path or containing directory.\n' >&2
    usage >&2
    exit 2
fi

if ! command -v keymap >/dev/null 2>&1; then
    printf 'Error: required executable "keymap" was not found; install keymap-drawer and ensure keymap is on PATH.\n' >&2
    exit 127
fi

source_path=$1
if [[ -d $source_path ]]; then
    source_path=${source_path%/}/map.json
fi

if [[ ! -f $source_path ]]; then
    printf 'Error: source map.json does not exist or is not a file: %s\n' "$source_path" >&2
    exit 1
fi

output_dir=$(dirname -- "$source_path")
output_path=$output_dir/keymap.svg
temp_dir=$(mktemp -d -- "$output_dir/.draw-keymap.XXXXXX") || {
    printf 'Error: could not create temporary files beside %s\n' "$output_path" >&2
    exit 1
}
cleanup() {
    rm -rf -- "$temp_dir"
}
trap cleanup EXIT

if ! keymap parse -q "$source_path" > "$temp_dir/keymap.yaml"; then
    printf 'Error: could not parse source map.json: %s\n' "$source_path" >&2
    exit 1
fi

if ! keymap draw "$temp_dir/keymap.yaml" > "$temp_dir/keymap.svg"; then
    printf 'Error: could not draw SVG from source map.json: %s\n' "$source_path" >&2
    exit 1
fi

if [[ ! -s $temp_dir/keymap.svg || ! -r $temp_dir/keymap.svg ]]; then
    printf 'Error: keymap draw produced an empty or unreadable SVG.\n' >&2
    exit 1
fi

if ! mv -f -- "$temp_dir/keymap.svg" "$output_path"; then
    printf 'Error: could not replace output SVG: %s\n' "$output_path" >&2
    exit 1
fi

printf 'Generated %s\n' "$output_path"
