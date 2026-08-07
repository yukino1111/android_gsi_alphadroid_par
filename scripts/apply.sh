#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_dir=$(dirname "$script_dir")
patch_dir="$repo_dir/patches"
source_root=${1:-${ANDROID_BUILD_TOP:-}}

if [[ -z "$source_root" ]]; then
  echo "usage: $0 <android-source-root>" >&2
  echo "or export ANDROID_BUILD_TOP before running this script" >&2
  exit 2
fi

source_root=$(realpath "$source_root")
if [[ ! -d "$source_root/.repo" ]]; then
  echo "not an Android repo checkout: $source_root" >&2
  exit 2
fi

while IFS=$'\t' read -r patch_name project base_revision; do
  [[ -z "$patch_name" || "$patch_name" == \#* ]] && continue

  project_dir="$source_root/$project"
  patch_file="$patch_dir/$patch_name"
  if [[ ! -d "$project_dir" || ! -f "$patch_file" ]]; then
    echo "missing project or patch: $project / $patch_name" >&2
    exit 1
  fi

  current_revision=$(git -C "$project_dir" rev-parse HEAD)
  if [[ "$current_revision" != "$base_revision" ]]; then
    echo "base revision mismatch: $project" >&2
    echo "  expected: $base_revision" >&2
    echo "  current:  $current_revision" >&2
    exit 1
  fi

  if git -C "$project_dir" apply --reverse --check "$patch_file" >/dev/null 2>&1; then
    echo "already applied: $project"
    continue
  fi

  git -C "$project_dir" apply --check "$patch_file"
  git -C "$project_dir" apply "$patch_file"
  echo "applied: $project"
done < "$patch_dir/series.tsv"

echo "ROM source patches applied successfully."
