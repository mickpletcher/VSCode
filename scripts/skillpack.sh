#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "$0")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
output_dir=${1:-"$repo_root/dist/skillpack"}
skills_dir="$output_dir/skills"
manifest_file="$output_dir/manifest.txt"

rm -rf "$output_dir"
mkdir -p "$skills_dir"

printf 'skillpack\n' > "$manifest_file"
printf 'source=%s\n' "$repo_root" >> "$manifest_file"

copied_any=false

for entry in "$repo_root"/*; do
  if [[ -d "$entry" && -f "$entry/SKILL.md" ]]; then
    skill_name=$(basename "$entry")
    cp -R "$entry" "$skills_dir/$skill_name"
    printf '%s\n' "$skill_name" >> "$manifest_file"
    copied_any=true
  fi
done

if [[ "$copied_any" == false ]]; then
  echo "No skill directories found under $repo_root" >&2
  exit 1
fi

cp "$repo_root/README.md" "$output_dir/README.md"

if [[ -f "$repo_root/LICENSE" ]]; then
  cp "$repo_root/LICENSE" "$output_dir/LICENSE"
fi

tar -czf "$output_dir.tar.gz" -C "$(dirname "$output_dir")" "$(basename "$output_dir")"

echo "Created skillpack at $output_dir"
echo "Created archive at $output_dir.tar.gz"