#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/frontend-craft"

echo "Uninstalling Frontend Craft plugin..."

if [[ -d "$SKILL_DIR" ]]; then
    rm -rf "$SKILL_DIR"
    echo "Removed skill: $SKILL_DIR"
else
    echo "Skill directory not found, nothing to remove."
fi

echo "Done."
