#!/usr/bin/env bash
# gen-image.sh — Automatic image generation with fallback chain
# Usage: gen-image.sh "prompt" output.jpg [width] [height]
# Strategy: Together AI FLUX → HuggingFace FLUX → Unsplash stock → CSS gradient

set -euo pipefail

PROMPT="${1:-"minimal clean product hero, white background, premium"}"
OUTPUT="${2:-"output.jpg"}"
WIDTH="${3:-1440}"
HEIGHT="${4:-810}"
ASPECT_KEYWORDS=$(echo "$PROMPT" | tr ' ' ',' | cut -d',' -f1-4)

log() { echo "🎨 gen-image: $*" >&2; }
success() { echo "✅ gen-image: $*" >&2; }
warn() { echo "⚠️  gen-image: $*" >&2; }

mkdir -p "$(dirname "$OUTPUT")"

# ── Strategy 1: Together AI FLUX.1-schnell ────────────────────────────────────
if [[ -n "${TOGETHER_API_KEY:-}" ]]; then
  log "Trying Together AI FLUX.1-schnell..."
  RESPONSE=$(curl -s -X POST "https://api.together.xyz/v1/images/generations" \
    -H "Authorization: Bearer $TOGETHER_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
      \"model\": \"black-forest-labs/FLUX.1-schnell-Free\",
      \"prompt\": \"$PROMPT\",
      \"width\": $WIDTH,
      \"height\": $HEIGHT,
      \"steps\": 4,
      \"n\": 1
    }" 2>/dev/null)

  URL=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['data'][0]['url'])" 2>/dev/null || true)

  if [[ -n "$URL" && "$URL" != "None" ]]; then
    curl -sL "$URL" -o "$OUTPUT"
    success "Together AI → $OUTPUT"
    exit 0
  else
    ERR=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('error',{}).get('message','unknown')[:80])" 2>/dev/null || echo "unknown error")
    warn "Together AI failed: $ERR"
  fi
fi

# ── Strategy 2: HuggingFace FLUX.1-schnell ───────────────────────────────────
if [[ -n "${HF_TOKEN:-}" ]]; then
  log "Trying HuggingFace FLUX.1-schnell..."
  HTTP_STATUS=$(curl -s -X POST \
    "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-schnell" \
    -H "Authorization: Bearer $HF_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"inputs\": \"$PROMPT\", \"parameters\": {\"width\": $WIDTH, \"height\": $HEIGHT}}" \
    -o "$OUTPUT" -w "%{http_code}" 2>/dev/null)

  if [[ "$HTTP_STATUS" == "200" ]] && file "$OUTPUT" 2>/dev/null | grep -q -i "image"; then
    success "HuggingFace FLUX → $OUTPUT"
    exit 0
  else
    warn "HuggingFace failed (HTTP $HTTP_STATUS)"
    rm -f "$OUTPUT"
  fi
fi

# ── Strategy 3: Loremflickr (keyword-based, no API key, always works) ─────────
log "Falling back to Loremflickr stock photo..."
KEYWORDS=$(echo "$PROMPT" | python3 -c "
import sys
words = sys.stdin.read().lower().split()
stop = {'the','a','an','and','or','with','for','of','in','on','at','no','not',
        'clean','minimal','premium','quality','high','modern','image','photo',
        'background','white','product','hero','professional'}
kept = [w.strip('.,') for w in words if w.strip('.,') not in stop and len(w) > 3]
print(','.join(kept[:3]) if kept else 'minimal')
" 2>/dev/null || echo "minimal")

# Try with keywords, then generic
for KW in "$KEYWORDS" "minimal" "abstract"; do
  HTTP_STATUS=$(curl -sL "https://loremflickr.com/${WIDTH}/${HEIGHT}/${KW}" \
    -o "$OUTPUT" -w "%{http_code}" 2>/dev/null)
  if [[ "$HTTP_STATUS" == "200" ]] && [[ -s "$OUTPUT" ]] && \
     file "$OUTPUT" 2>/dev/null | grep -qi "image"; then
    success "Loremflickr stock → $OUTPUT (keyword: $KW)"
    exit 0
  fi
  rm -f "$OUTPUT"
done

# ── Strategy 4: Picsum (random high-quality, no key) ─────────────────────────
log "Falling back to Lorem Picsum..."
HTTP_STATUS=$(curl -sL "https://picsum.photos/${WIDTH}/${HEIGHT}" \
  -o "$OUTPUT" -w "%{http_code}" 2>/dev/null)

if [[ "$HTTP_STATUS" == "200" ]] && [[ -s "$OUTPUT" ]]; then
  success "Lorem Picsum → $OUTPUT"
  exit 0
fi

# ── Strategy 5: CSS gradient placeholder (always works) ──────────────────────
warn "All image sources failed. Writing CSS gradient placeholder note."
cat > "${OUTPUT%.jpg}.css-fallback.txt" << EOF
/* CSS gradient hero fallback — replace with real image */
.hero-bg {
  background: linear-gradient(135deg, oklch(20% 0.02 240) 0%, oklch(35% 0.04 220) 100%);
  min-height: ${HEIGHT}px;
}
EOF

warn "Wrote CSS fallback to ${OUTPUT%.jpg}.css-fallback.txt"
exit 1
