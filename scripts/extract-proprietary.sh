#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(dirname "$script_dir")"
list_file="$repo_dir/proprietary-files.txt"
system_image="${1:?usage: $0 REFERENCE_SYSTEM_IMAGE ANDROID_SOURCE_ROOT}"
source_root="${2:?usage: $0 REFERENCE_SYSTEM_IMAGE ANDROID_SOURCE_ROOT}"
device_root="$source_root/device/phh/treble"

die() {
  printf '%s\n' "$*" >&2
  exit 1
}

command -v debugfs >/dev/null 2>&1 || die "debugfs is required"
[ -f "$system_image" ] || die "reference system image not found: $system_image"
[ -d "$device_root/.git" ] || die "Treble device project not found: $device_root"

work_dir="$(mktemp -d "${TMPDIR:-/tmp}/par-rom-extract.XXXXXX")"
cleanup() {
  rm -rf -- "$work_dir"
}
trap cleanup EXIT

while IFS='|' read -r source_path destination expected_sha256; do
  case "$source_path" in
    ''|'#'*) continue ;;
  esac

  extracted="$work_dir/$(basename "$destination")"
  debugfs -R "dump -p $source_path $extracted" "$system_image" >/dev/null 2>&1 || \
    die "failed to extract $source_path"
  actual_sha256="$(sha256sum "$extracted" | awk '{print $1}')"
  [ "$actual_sha256" = "$expected_sha256" ] || \
    die "checksum mismatch for $source_path: $actual_sha256"
  install -Dm0644 "$extracted" "$device_root/$destination"
  printf 'extracted: %s\n' "$destination"
done < "$list_file"

echo "Proprietary TurboAdapter files extracted successfully."
