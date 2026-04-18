#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "$0")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
default_output_dir="$repo_root/dist/skillpack"
output_dir="$default_output_dir"
manifest_format="text"
validate_only=false

usage() {
  cat <<'EOF'
Usage:
  ./scripts/skillpack.sh [output-dir]
  ./scripts/skillpack.sh [--output DIR] [--manifest text|json] [--validate]

Options:
  --output DIR         Write the skillpack to DIR.
  --output=DIR         Same as --output DIR.
  --manifest FORMAT    Manifest format: text or json.
  --manifest=FORMAT    Same as --manifest FORMAT.
  --validate           Validate skill folders and exit without packaging.
  --help               Show this help text.
EOF
}

json_escape() {
  local value="$1"
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  value=${value//$'\r'/\\r}
  value=${value//$'\t'/\\t}
  printf '%s' "$value"
}

trim_quotes() {
  local value="$1"

  if [[ "$value" == \"*\" && "$value" == *\" ]]; then
    value=${value:1:-1}
  elif [[ "$value" == \'.*\' ]]; then
    value=${value:1:-1}
  fi

  printf '%s' "$value"
}

extract_frontmatter_value() {
  local file_path="$1"
  local key="$2"
  local value

  value=$(sed -n "s/^$key:[[:space:]]*//p" "$file_path" | head -n 1)
  trim_quotes "$value"
}

skill_dirs=()

collect_skills() {
  skill_dirs=()

  for entry in "$repo_root"/*; do
    if [[ -d "$entry" && -f "$entry/SKILL.md" ]]; then
      skill_dirs+=("$entry")
    fi
  done
}

validate_skills() {
  local skill_dir skill_name

  collect_skills

  if [[ ${#skill_dirs[@]} -eq 0 ]]; then
    echo "No skill directories found under $repo_root" >&2
    exit 1
  fi

  for skill_dir in "${skill_dirs[@]}"; do
    skill_name=$(basename "$skill_dir")

    if [[ ! -f "$skill_dir/README.md" ]]; then
      echo "Missing README.md for skill: $skill_name" >&2
      exit 1
    fi

    if ! grep -q '^---$' "$skill_dir/SKILL.md"; then
      echo "Missing YAML frontmatter markers in $skill_name/SKILL.md" >&2
      exit 1
    fi

    if ! grep -q '^name:' "$skill_dir/SKILL.md"; then
      echo "Missing name field in $skill_name/SKILL.md" >&2
      exit 1
    fi

    if ! grep -q '^description:' "$skill_dir/SKILL.md"; then
      echo "Missing description field in $skill_name/SKILL.md" >&2
      exit 1
    fi
  done
}

write_text_manifest() {
  local manifest_file="$output_dir/manifest.txt"
  local skill_dir skill_name

  printf 'skillpack\n' > "$manifest_file"
  printf 'source=%s\n' "$repo_root" >> "$manifest_file"

  for skill_dir in "${skill_dirs[@]}"; do
    skill_name=$(basename "$skill_dir")
    printf '%s\n' "$skill_name" >> "$manifest_file"
  done
}

write_json_manifest() {
  local manifest_file="$output_dir/manifest.json"
  local generated_at skill_dir skill_name skill_description first=true

  generated_at=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  {
    printf '{\n'
    printf '  "kind": "skillpack",\n'
    printf '  "schema_version": 2,\n'
    printf '  "manifest_format": "json",\n'
    printf '  "source": "%s",\n' "$(json_escape "$repo_root")"
    printf '  "output": "%s",\n' "$(json_escape "$output_dir")"
    printf '  "archive": "%s",\n' "$(json_escape "$output_dir.tar.gz")"
    printf '  "generated_at": "%s",\n' "$generated_at"
    printf '  "skill_count": %s,\n' "${#skill_dirs[@]}"
    printf '  "skills": [\n'

    for skill_dir in "${skill_dirs[@]}"; do
      skill_name=$(basename "$skill_dir")
      skill_description=$(extract_frontmatter_value "$skill_dir/SKILL.md" "description")

      if [[ "$first" == true ]]; then
        first=false
      else
        printf ',\n'
      fi

      printf '    {"name": "%s", "path": "%s", "description": "%s", "readme": "%s", "skill_file": "%s"}' \
        "$(json_escape "$skill_name")" \
        "$(json_escape "skills/$skill_name")" \
        "$(json_escape "$skill_description")" \
        "$(json_escape "skills/$skill_name/README.md")" \
        "$(json_escape "skills/$skill_name/SKILL.md")"
    done

    printf '\n'
    printf '  ]\n'
    printf '}\n'
  } > "$manifest_file"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output)
      output_dir="$2"
      shift 2
      ;;
    --output=*)
      output_dir="${1#*=}"
      shift
      ;;
    --manifest)
      manifest_format="$2"
      shift 2
      ;;
    --manifest=*)
      manifest_format="${1#*=}"
      shift
      ;;
    --validate)
      validate_only=true
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    -* )
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      output_dir="$1"
      shift
      ;;
  esac
done

if [[ "$manifest_format" != "text" && "$manifest_format" != "json" ]]; then
  echo "Invalid manifest format: $manifest_format" >&2
  exit 1
fi

validate_skills

if [[ "$validate_only" == true ]]; then
  echo "Validated ${#skill_dirs[@]} skill directories"
  exit 0
fi

skills_dir="$output_dir/skills"

rm -rf "$output_dir"
mkdir -p "$skills_dir"

for skill_dir in "${skill_dirs[@]}"; do
  skill_name=$(basename "$skill_dir")
  cp -R "$skill_dir" "$skills_dir/$skill_name"
done

cp "$repo_root/README.md" "$output_dir/README.md"

if [[ -f "$repo_root/LICENSE" ]]; then
  cp "$repo_root/LICENSE" "$output_dir/LICENSE"
fi

if [[ "$manifest_format" == "json" ]]; then
  write_json_manifest
else
  write_text_manifest
fi

tar -czf "$output_dir.tar.gz" -C "$(dirname "$output_dir")" "$(basename "$output_dir")"

echo "Created skillpack at $output_dir"
echo "Created archive at $output_dir.tar.gz"