#!/usr/bin/env bash
# gen-assets.sh — Orchestrate all asset generation for a frontend-craft project
# Usage: gen-assets.sh [research.json path]
# Reads research.json, generates all images + hero video automatically

set -euo pipefail

RESEARCH="${1:-"assets/research.json"}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="assets"
IMG_DIR="$ASSETS_DIR/images"

log()     { echo "📦 gen-assets: $*"; }
success() { echo "✅ $*"; }
warn()    { echo "⚠️  $*"; }

mkdir -p "$IMG_DIR"

# ── Load research context ─────────────────────────────────────────────────────
if [[ -f "$RESEARCH" ]]; then
  PRODUCT=$(python3 -c "import json; d=json.load(open('$RESEARCH')); print(d.get('product','product'))" 2>/dev/null || echo "product")
  AUDIENCE=$(python3 -c "import json; d=json.load(open('$RESEARCH')); print(d.get('audience','professionals'))" 2>/dev/null || echo "professionals")
  STYLE=$(python3 -c "import json; d=json.load(open('$RESEARCH')); print(d.get('style','minimal clean'))" 2>/dev/null || echo "minimal clean")
  log "Product: $PRODUCT | Audience: $AUDIENCE | Style: $STYLE"
else
  warn "No research.json found. Using generic prompts."
  PRODUCT="product"
  AUDIENCE="professionals"
  STYLE="minimal clean"
fi

# ── Image generation map ──────────────────────────────────────────────────────
declare -A IMAGES=(
  ["hero"]="$STYLE hero for $PRODUCT, high quality, no text, $AUDIENCE"
  ["features"]="$STYLE abstract feature illustration, $PRODUCT, soft light"
  ["social-proof"]="$STYLE team collaboration, $AUDIENCE, office, natural light"
  ["cta-bg"]="$STYLE gradient texture background, professional, $PRODUCT"
)

for NAME in "${!IMAGES[@]}"; do
  OUT="$IMG_DIR/$NAME.jpg"
  if [[ -f "$OUT" ]]; then
    log "Skipping $NAME (already exists)"
    continue
  fi
  log "Generating: $NAME..."
  bash "$SCRIPT_DIR/gen-image.sh" "${IMAGES[$NAME]}" "$OUT" 1440 810 || \
    warn "Failed: $NAME — manual image needed"
done

# ── Hero video ────────────────────────────────────────────────────────────────
HERO_VIDEO=$(ls "$ASSETS_DIR"/hero-*.mp4 2>/dev/null | head -1 || true)
if [[ -z "$HERO_VIDEO" ]]; then
  log "Generating hero video..."
  bash "$SCRIPT_DIR/gen-video.sh" "$STYLE $PRODUCT" "$ASSETS_DIR/" || \
    warn "Hero video generation failed"
else
  log "Hero video exists: $HERO_VIDEO"
fi

# ── Summary ───────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════"
echo "  Asset generation complete"
echo "═══════════════════════════════"
echo ""
ls -lh "$IMG_DIR"/*.jpg 2>/dev/null && echo "" || true
ls -lh "$ASSETS_DIR"/*.mp4 "$ASSETS_DIR"/*.webm 2>/dev/null || true
echo ""
warn "Replace any CSS fallbacks with real images when possible"
