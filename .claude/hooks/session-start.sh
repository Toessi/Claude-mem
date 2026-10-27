#!/bin/bash
set -euo pipefail

# Only run in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Repo dependencies (npm install, not ci, so the cached container state is reused)
cd "${CLAUDE_PROJECT_DIR:-.}"
npm install

# Install the claude-mem plugin and start its worker. Run from $HOME because inside
# the repo npx resolves the local package, which has no bin entry.
cd "$HOME"
npx --yes claude-mem install
npx --yes claude-mem start
