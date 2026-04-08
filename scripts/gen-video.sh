#!/usr/bin/env bash
# gen-video.sh — Automatic stock video fetch with fallback
# Usage: gen-video.sh "keywords" output-dir/
# Strategy: Pexels API → Pixabay API → ffmpeg CSS gradient video

set -euo pipefail

KEYWORDS="${1:-"minimal product"}"
OUTDIR="${2:-"assets/"}"
ORIENTATION="landscape"

log() { echo "🎬 gen-video: $*" >&2; }
success() { echo "✅ gen-video: $*" >&2; }
warn() { echo "⚠️  gen-video: $*" >&2; }

mkdir -p "$OUTDIR"
SLUG=$(echo "$KEYWORDS" | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]//g')

# ── Strategy 1: Pexels API (free, needs PEXELS_API_KEY) ──────────────────────
if [[ -n "${PEXELS_API_KEY:-}" ]]; then
  log "Trying Pexels API (keywords: $KEYWORDS)..."
  QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$KEYWORDS'))")
  RESPONSE=$(curl -s "https://api.pexels.com/videos/search?query=$QUERY&orientation=$ORIENTATION&size=medium&per_page=5" \
    -H "Authorization: $PEXELS_API_KEY" 2>/dev/null)

  VIDEO_URL=$(echo "$RESPONSE" | python3 -c "
import sys, json
d = json.load(sys.stdin)
videos = d.get('videos', [])
if not videos: exit(1)
# get HD file
files = videos[0].get('video_files', [])
hd = sorted([f for f in files if f.get('width',0) >= 1280], key=lambda x: -x.get('width',0))
if hd: print(hd[0]['link'])
else: print(files[0]['link'])
" 2>/dev/null || true)

  if [[ -n "$VIDEO_URL" ]]; then
    OUT_MP4="$OUTDIR/hero-$SLUG.mp4"
    curl -sL "$VIDEO_URL" -o "$OUT_MP4"
    if [[ -s "$OUT_MP4" ]]; then
      # compress + convert to webm
      if command -v ffmpeg &>/dev/null; then
        ffmpeg -i "$OUT_MP4" -vcodec libx264 -crf 28 -movflags +faststart \
          -an "${OUT_MP4%.mp4}-compressed.mp4" -y 2>/dev/null
        ffmpeg -i "$OUT_MP4" -c:v libvpx-vp9 -crf 35 -b:v 0 \
          "${OUT_MP4%.mp4}.webm" -y 2>/dev/null
        mv "${OUT_MP4%.mp4}-compressed.mp4" "$OUT_MP4"
        log "Compressed: H.264 + WebM"
      fi
      success "Pexels video → $OUT_MP4"
      echo "$OUT_MP4"
      exit 0
    fi
  fi
  warn "Pexels: no results for '$KEYWORDS'"
fi

# ── Strategy 2: Pixabay API (free, needs PIXABAY_API_KEY) ────────────────────
if [[ -n "${PIXABAY_API_KEY:-}" ]]; then
  log "Trying Pixabay API..."
  QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$KEYWORDS'))")
  RESPONSE=$(curl -s \
    "https://pixabay.com/api/videos/?key=$PIXABAY_API_KEY&q=$QUERY&video_type=film&per_page=5" \
    2>/dev/null)

  VIDEO_URL=$(echo "$RESPONSE" | python3 -c "
import sys, json
d = json.load(sys.stdin)
hits = d.get('hits', [])
if not hits: exit(1)
videos = hits[0].get('videos', {})
hd = videos.get('large', {}).get('url') or videos.get('medium', {}).get('url')
if hd: print(hd)
" 2>/dev/null || true)

  if [[ -n "$VIDEO_URL" ]]; then
    OUT_MP4="$OUTDIR/hero-$SLUG.mp4"
    curl -sL "$VIDEO_URL" -o "$OUT_MP4"
    if [[ -s "$OUT_MP4" ]]; then
      if command -v ffmpeg &>/dev/null; then
        ffmpeg -i "$OUT_MP4" -vcodec libx264 -crf 28 -movflags +faststart \
          -an "${OUT_MP4%.mp4}-compressed.mp4" -y 2>/dev/null && \
          mv "${OUT_MP4%.mp4}-compressed.mp4" "$OUT_MP4"
        ffmpeg -i "$OUT_MP4" -c:v libvpx-vp9 -crf 35 -b:v 0 \
          "${OUT_MP4%.mp4}.webm" -y 2>/dev/null
      fi
      success "Pixabay video → $OUT_MP4"
      echo "$OUT_MP4"
      exit 0
    fi
  fi
  warn "Pixabay: no results"
fi

# ── Strategy 3: Generate gradient video with ffmpeg ──────────────────────────
if command -v ffmpeg &>/dev/null; then
  log "Generating CSS gradient video with ffmpeg..."
  OUT_MP4="$OUTDIR/hero-gradient.mp4"
  ffmpeg -f lavfi \
    -i "color=c=0x1a1a2e:size=1920x1080:rate=30" \
    -vf "drawtext=text='':x=0:y=0" \
    -t 10 -c:v libx264 -crf 28 -movflags +faststart \
    "$OUT_MP4" -y 2>/dev/null

  ffmpeg -i "$OUT_MP4" -c:v libvpx-vp9 -crf 35 -b:v 0 \
    "${OUT_MP4%.mp4}.webm" -y 2>/dev/null

  success "Generated gradient video → $OUT_MP4"
  echo "$OUT_MP4"
  exit 0
fi

warn "No video source available. Add PEXELS_API_KEY or PIXABAY_API_KEY to secrets.env"
exit 1
