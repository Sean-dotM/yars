#!/usr/bin/env bash
set -euo pipefail
# Compile all YARA rules in yara/
# Expects the YARA-X 'yr' binary to already be on PATH.
# Usage: scripts/compile.yara.sh [rules_dir]

RULES_DIR="${1:-${GITHUB_WORKSPACE:-$(pwd)}/yara}"
OUT_DIR="${RUNNER_TEMP:-$(mktemp -d)}"

if ! command -v yr >/dev/null 2>&1; then
  echo "::error::yr not found on PATH. Install YARA-X first." >&2
  exit 1
fi

if [ ! -d "${RULES_DIR}" ]; then
  echo "::error::Rules directory not found: ${RULES_DIR}" >&2
  exit 1
fi

mapfile -t rules < <(
  find "${RULES_DIR}" -type f \( -name '*.yar' -o -name '*.yara' \) | sort
)

if [ "${#rules[@]}" -eq 0 ]; then
  echo "::error::No YARA rules found under ${RULES_DIR}" >&2
  exit 1
fi

for rule in "${rules[@]}"; do
  rel="${rule#"${RULES_DIR}"/}"
  out="${OUT_DIR}/${rel%.*}.yarac"
  mkdir -p "$(dirname "${out}")"

  echo "::group::Compiling ${rule}"
  yr compile "${rule}" -o "${out}"
  echo "::endgroup::"
done

echo "Compiled ${#rules[@]} rules to ${OUT_DIR}"