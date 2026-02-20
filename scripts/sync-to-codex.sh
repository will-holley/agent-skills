#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/skills"
DEST_DIR="${CLAUDE_CODE_SKILLS_DIR:-$HOME/.claude/skills}"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source skills directory not found: $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

shopt -s dotglob nullglob

# Sync repo skills into the Claude Code skills inventory.
# Conflicting skills are replaced entirely; unrelated existing skills remain.
for src_path in "$SOURCE_DIR"/*; do
  skill_name="$(basename "$src_path")"
  dest_path="$DEST_DIR/$skill_name"

  rm -rf "$dest_path"
  cp -R "$src_path" "$dest_path"
done

echo "Synced skills from $SOURCE_DIR to $DEST_DIR"
