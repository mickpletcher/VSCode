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
  elif [[ "$value" == \'*\' && "$value" == *\' ]]; then
    value=${value:1:-1}
  fi

  printf '%s' "$value"
}

file_sha256() {
  local file_path="$1"

  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file_path" | awk '{print $1}'
    return
  fi

  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file_path" | awk '{print $1}'
    return
  fi

  if command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 -r "$file_path" | awk '{print $1}'
    return
  fi

  echo "No SHA-256 tool is available" >&2
  exit 1
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
  local skill_dir skill_name declared_name name_length desc_length

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
    if ! grep -q '^version:' "$skill_dir/SKILL.md"; then
      echo "Missing version field in $skill_name/SKILL.md" >&2
      exit 1
    fi

    # Enforce Agent Skills spec: name must match folder name exactly
    declared_name=$(extract_frontmatter_value "$skill_dir/SKILL.md" "name")
    if [[ "$declared_name" != "$skill_name" ]]; then
      echo "Name mismatch in $skill_name/SKILL.md: frontmatter declares '$declared_name' but folder is '$skill_name'" >&2
      echo "VS Code will not load this skill until these match." >&2
      exit 1
    fi

    # Enforce spec: name must be lowercase letters, digits, and hyphens only
    if [[ ! "$declared_name" =~ ^[a-z0-9-]+$ ]]; then
      echo "Invalid name '$declared_name' in $skill_name/SKILL.md: must be lowercase letters, digits, and hyphens only" >&2
      exit 1
    fi

    # Enforce spec: name must be max 64 characters
    name_length=${#declared_name}
    if [[ $name_length -gt 64 ]]; then
      echo "Name too long in $skill_name/SKILL.md: $name_length characters (max 64)" >&2
      exit 1
    fi

    # Enforce spec: description must be max 1024 characters
    desc_length=$(extract_frontmatter_value "$skill_dir/SKILL.md" "description" | wc -c)
    if [[ $desc_length -gt 1024 ]]; then
      echo "Description too long in $skill_name/SKILL.md: $desc_length characters (max 1024)" >&2
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
  local generated_at root_readme_hash license_hash skill_dir skill_name skill_version skill_description
  local skill_readme_hash skill_file_hash first=true

  generated_at=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  root_readme_hash=$(file_sha256 "$repo_root/README.md")

  if [[ -f "$repo_root/LICENSE" ]]; then
    license_hash=$(file_sha256 "$repo_root/LICENSE")
  fi

  {
    printf '{\n'
    printf '  "kind": "skillpack",\n'
    printf '  "schema_version": 3,\n'
    printf '  "manifest_format": "json",\n'
    printf '  "source": "%s",\n' "$(json_escape "$repo_root")"
    printf '  "output": "%s",\n' "$(json_escape "$output_dir")"
    printf '  "archive": "%s",\n' "$(json_escape "$output_dir.zip")"
    printf '  "generated_at": "%s",\n' "$generated_at"
    printf '  "hash_algorithm": "sha256",\n'
    printf '  "skill_count": %s,\n' "${#skill_dirs[@]}"
    printf '  "bundle_files": [\n'
    printf '    {"path": "README.md", "sha256": "%s"}' "$root_readme_hash"

    if [[ -n "${license_hash:-}" ]]; then
      printf ',\n'
      printf '    {"path": "LICENSE", "sha256": "%s"}' "$license_hash"
    fi

    printf '\n'
    printf '  ],\n'
    printf '  "skills": [\n'

    for skill_dir in "${skill_dirs[@]}"; do
      skill_name=$(basename "$skill_dir")
      skill_version=$(extract_frontmatter_value "$skill_dir/SKILL.md" "version")
      skill_description=$(extract_frontmatter_value "$skill_dir/SKILL.md" "description")
      skill_readme_hash=$(file_sha256 "$skill_dir/README.md")
      skill_file_hash=$(file_sha256 "$skill_dir/SKILL.md")

      if [[ "$first" == true ]]; then
        first=false
      else
        printf ',\n'
      fi

      printf '    {"name": "%s", "version": "%s", "path": "%s", "description": "%s", "readme": "%s", "skill_file": "%s", "files": [{"path": "%s", "sha256": "%s"}, {"path": "%s", "sha256": "%s"}]}' \
        "$(json_escape "$skill_name")" \
        "$(json_escape "$skill_version")" \
        "$(json_escape "skills/$skill_name")" \
        "$(json_escape "$skill_description")" \
        "$(json_escape "skills/$skill_name/README.md")" \
        "$(json_escape "skills/$skill_name/SKILL.md")" \
        "$(json_escape "skills/$skill_name/README.md")" \
        "$skill_readme_hash" \
        "$(json_escape "skills/$skill_name/SKILL.md")" \
        "$skill_file_hash"
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

if ! command -v zip >/dev/null 2>&1; then
  echo "zip is not available" >&2
  exit 1
fi

(cd "$(dirname "$output_dir")" && zip -qr "$(basename "$output_dir").zip" "$(basename "$output_dir")")

echo "Created skillpack at $output_dir"
echo "Created archive at $output_dir.zip"