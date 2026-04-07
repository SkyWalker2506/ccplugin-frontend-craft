#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$HOME/.claude/skills/frontend-craft"

echo "Installing Frontend Craft plugin..."

mkdir -p "$SKILL_DIR"
cp "$PLUGIN_DIR/skills/SKILL.md" "$SKILL_DIR/SKILL.md"

echo "Installed skill: frontend-craft -> $SKILL_DIR/SKILL.md"
echo "Done. Use /frontend-craft in any Claude Code session."
