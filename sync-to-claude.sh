#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/skills"
DEST_DIR="${CLAUDE_SKILLS_DIR:-${HOME}/.claude/skills}"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Source skills directory not found: ${SOURCE_DIR}" >&2
  exit 1
fi

mkdir -p "${DEST_DIR}"

shopt -s nullglob
skill_dirs=("${SOURCE_DIR}"/*)
shopt -u nullglob

if [[ ${#skill_dirs[@]} -eq 0 ]]; then
  echo "No skill directories found in ${SOURCE_DIR}."
  exit 0
fi

synced_count=0

for skill_dir in "${skill_dirs[@]}"; do
  [[ -d "${skill_dir}" ]] || continue
  skill_name="$(basename "${skill_dir}")"
  target_dir="${DEST_DIR}/${skill_name}"

  if [[ "${DRY_RUN}" == true ]]; then
    if [[ -e "${target_dir}" ]]; then
      echo "[dry-run] Would replace ${target_dir}"
    else
      echo "[dry-run] Would install ${target_dir}"
    fi
    ((synced_count+=1))
    continue
  fi

  rm -rf "${target_dir}"
  cp -R "${skill_dir}" "${target_dir}"
  echo "Synced ${skill_name} -> ${target_dir}"
  ((synced_count+=1))
done

if [[ "${DRY_RUN}" == true ]]; then
  echo "[dry-run] ${synced_count} skill(s) would be synced to ${DEST_DIR}"
else
  echo "Done. Synced ${synced_count} skill(s) to ${DEST_DIR}"
fi
