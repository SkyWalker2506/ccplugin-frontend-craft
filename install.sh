#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$HOME/.claude/skills/frontend-craft"
FORCE=false

# Parse flags
for arg in "$@"; do
    case "$arg" in
        --force) FORCE=true ;;
    esac
done

# 1. $HOME empty check
if [[ -z "${HOME:-}" ]]; then
    echo "Error: \$HOME is not set. Cannot determine installation directory." >&2
    exit 1
fi

echo "Installing Frontend Craft plugin..."

# 2. Symlink check on $SKILL_DIR
if [[ -L "$SKILL_DIR" ]]; then
    echo "Warning: '$SKILL_DIR' is a symlink. Refusing to install over a symlink." >&2
    exit 1
fi

# 3. Existing installation backup
if [[ -d "$SKILL_DIR" ]]; then
    if [[ "$FORCE" == true ]]; then
        echo "Existing installation found. --force specified, skipping backup."
    else
        read -r -p "Existing installation found at '$SKILL_DIR'. Back it up? [Y/n] " answer
        answer="${answer:-Y}"
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            BACKUP_DIR="${SKILL_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
            cp -r "$SKILL_DIR" "$BACKUP_DIR"
            echo "Backup created: $BACKUP_DIR"
        else
            echo "Skipping backup."
        fi
    fi
fi

mkdir -p "$SKILL_DIR"
cp "$PLUGIN_DIR/skills/SKILL.md" "$SKILL_DIR/SKILL.md"

echo "Installed skill: frontend-craft -> $SKILL_DIR/SKILL.md"
echo "Done. Use /frontend-craft in any Claude Code session."
