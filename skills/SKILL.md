---
name: frontend-craft
description: "ANF frontend pipeline — high-end site/app build. Triggers: frontend craft, frontend pipeline, ANF, high-end site, web craft, premium frontend"
argument-hint: "[setup|assemble|normalize|fill|polish]"
user-invocable: true
---

# /frontend-craft — High-End Frontend Pipeline

ANF (Assemble → Normalize → Fill) + Polish pipeline for building $5-10K quality websites and applications.

## Framework

| Phase | Command | What it does |
|-------|---------|-------------|
| Setup | `/frontend-craft setup` | Scaffold project, design tokens, taste skill |
| Assemble | `/frontend-craft assemble` | 21st.dev components, section layout |
| Normalize | `/frontend-craft normalize` | Unify design system, CSS custom properties |
| Fill | `/frontend-craft fill` | Research product, write real copy, generate assets |
| Polish | `/frontend-craft polish` | Animations, video, scroll effects, deploy |

## How to Use

1. **With ClaudeHQ sprint:** `hq frontend <project>` creates a 5-task sprint and dispatches automatically
2. **Standalone:** Call `/frontend-craft <phase>` in any project to run a specific phase manually

## Phase Details

### Setup
- Fetch Leon's Taste Skill: https://github.com/Leonxlnx/taste-skill
- Create folder structure: `src/`, `assets/`, `components/`, `public/`
- Define CSS custom properties:
  - Spacing: 8px grid system (`--space-xs` through `--space-2xl`)
  - Colors: `--color-primary`, `--color-surface`, `--color-muted`, `--color-accent`
  - Typography: max 2 font families, consistent scale
  - Radius: `--radius-sm`, `--radius-md`, `--radius-lg`

### Assemble (ANF: A)
- Read component prompts from `components/*.txt` (from 21st.dev "Copy Prompt" workflow)
- Implement each as a semantic `<section id="...">` element
- If no prompts exist: generate sections using taste skill principles
- All values via CSS custom properties — zero hard-coded colors/sizes

**Component workflow:**
1. Go to https://21st.dev
2. Browse and select components
3. Click "Copy Prompt" → "Claude Code"
4. Save as `components/01.txt`, `02.txt`, etc.
5. Run `/frontend-craft assemble`

### Normalize (ANF: N)
Replace all hard-coded values with CSS custom properties:
- Spacing: 8px base grid
- Typography: max 2 font families, consistent type scale
- Colors: 4 roles — primary / surface / muted / accent
- Buttons: single border-radius, single hover pattern
- Shadows: 3-level scale (soft / medium / strong)
- Motion: `--ease-default`, `--duration-fast` / `normal` / `slow`
- Purge purple defaults (#6366f1, indigo-500) if present

### Fill (ANF: F)
- Extract product/company info from project context
- Research: value propositions, target audience, competitor positioning
- Write `assets/research.json` with structured findings
- Replace all placeholder copy with real content:
  - Headlines: max 8 words
  - Sublines: max 20 words
  - CTAs: max 4 words
- Banned words: "leverage", "seamless", "revolutionary", "transformative"
- SEO: validate `<title>`, `<meta description>`, `<h1>` hierarchy
- **Asset generation:**
  - General images: Playground AI (playgroundai.com) — 500 free/day
  - Text-overlay images: Ideogram (ideogram.ai) — ~25 free/day
  - Prompt template: `"High quality [TYPE] for [PRODUCT]. Clean, minimal, premium. No text unless logo."`

### Polish
- **Hero video:** `<video autoplay loop muted playsinline>`, `object-fit: cover`, gradient mask
- **Scroll animation:** IntersectionObserver + requestAnimationFrame, or CSS `animation-timeline: scroll()`
- **Frame sequence:** If `assets/frames/` exists, build scroll-driven frame swap
- **Video compress:** `ffmpeg -i input.mp4 -vcodec libx264 -crf 28 output.mp4`
- **GIF creation:** `ffmpeg -i video.mp4 -vf "fps=15,scale=480:-1" output.gif`
- **Deploy:** Netlify (`netlify.toml` + `npx netlify-cli deploy --prod`)
- **Verify:** Lighthouse audit, target 90+ score

## Design Anti-Patterns (AVOID)

- `color: indigo-500` or any purple-as-default
- Generic card grid layouts everywhere
- Overused fonts (Inter on everything)
- Symmetric, template-looking layouts
- Stock hero patterns (gradient blob + floating mockup)

## Design Principles (FOLLOW)

- Asymmetric layouts with editorial spacing
- Strong typographic hierarchy (2 font families max)
- Intentional whitespace — let content breathe
- Unique section compositions — each section feels crafted
- Consistent but not monotonous rhythm

## Asset Generation Tools

| Tool | URL | Free Tier | Best For |
|------|-----|-----------|----------|
| Playground AI | playgroundai.com | 500/day | Hero, section bg, feature icons |
| Ideogram | ideogram.ai | ~25/day | Logos, text-overlay images |
| Higgsfield/Kling | higgsfield.ai | 66 credits/day | AI video, 5s clips |
| Netlify | netlify.com | Unlimited deploys | Free CDN hosting + SSL |
