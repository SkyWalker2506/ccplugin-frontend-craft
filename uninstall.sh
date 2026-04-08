#!/usr/bin/env bash
set -euo pipefail

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

SKILL_DIR="$HOME/.claude/skills/frontend-craft"

# 2. Path validation — must match expected pattern
EXPECTED_PREFIX="$HOME/.claude/skills/frontend-craft"
if [[ "$SKILL_DIR" != "$EXPECTED_PREFIX" ]]; then
    echo "Error: Unexpected skill directory path '$SKILL_DIR'. Aborting for safety." >&2
    exit 1
fi

# Extra guard: path must not contain traversal sequences
if [[ "$SKILL_DIR" == *".."* ]]; then
    echo "Error: Path contains '..' traversal sequence. Aborting." >&2
    exit 1
fi

echo "Uninstalling Frontend Craft plugin..."

if [[ -d "$SKILL_DIR" ]]; then
    # 3. Confirm before rm -rf (skip with --force)
    if [[ "$FORCE" == false ]]; then
        read -r -p "This will permanently remove '$SKILL_DIR'. Continue? [y/N] " answer
        answer="${answer:-N}"
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
            echo "Aborted."
            exit 0
        fi
    fi

    rm -rf "$SKILL_DIR"
    echo "Removed skill: $SKILL_DIR"
else
    echo "Skill directory not found, nothing to remove."
fi

echo "Done."
