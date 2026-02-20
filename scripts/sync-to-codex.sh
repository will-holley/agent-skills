#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_DIR="${REPO_ROOT}/skills"
DEST_DIR="${CODEX_SKILLS_DIR:-${HOME}/.codex/skills}"
CODEX_CLI_BIN="${CODEX_CLI_BIN:-codex}"
CODEX_CLI_SUBCOMMAND="${CODEX_CLI_SUBCOMMAND:-exec}"

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

  rm -rf "${target_dir}"
  cp -R "${skill_dir}" "${target_dir}"
  echo "Synced ${skill_name} -> ${target_dir}"
  ((synced_count+=1))
done

echo "Done. Synced ${synced_count} skill(s) to ${DEST_DIR}"

shopt -s nullglob
install_files=("${SOURCE_DIR}"/*/INSTALL.md)
shopt -u nullglob

if [[ ${#install_files[@]} -eq 0 ]]; then
  echo "No INSTALL.md files found under ${SOURCE_DIR}."
  exit 0
fi

for install_file in "${install_files[@]}"; do
  prompt="Open and execute the installation steps in ${install_file}."
  echo "Running Codex install prompt for ${install_file}"
  "${CODEX_CLI_BIN}" "${CODEX_CLI_SUBCOMMAND}" "${prompt}"
done
