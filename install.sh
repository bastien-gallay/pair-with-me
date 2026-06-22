#!/usr/bin/env bash
# pair-with-me — install the skill into ~/.claude/skills/
#
# Usage:
#   ./install.sh           # symlink (recommended — edits propagate)
#   ./install.sh --copy    # copy instead of symlink
#
# After install, use `/pair-with-me #<issue>` in Claude Code.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.claude/skills"
TARGET="$TARGET_DIR/pair-with-me"

mkdir -p "$TARGET_DIR"

if [[ "${1:-}" == "--copy" ]]; then
  rm -rf "$TARGET"
  cp -R "$REPO_DIR" "$TARGET"
  echo "✅ Skill copied to: $TARGET"
else
  ln -sfn "$REPO_DIR" "$TARGET"
  echo "✅ Skill linked: $TARGET → $REPO_DIR"
fi

echo
echo "Next: type /pair-with-me #<issue> in any Claude Code session."
