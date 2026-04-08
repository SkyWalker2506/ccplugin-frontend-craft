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
- Fetch Leon's Taste Skill (pinned): https://github.com/Leonxlnx/taste-skill/tree/main
  Note: Pin to specific commit SHA when fetching — check latest stable commit before use.
- Create folder structure: `src/`, `assets/`, `components/`, `public/`
- Define CSS custom properties:
  - Spacing: 8px grid system
    - `--space-xs: 4px`
    - `--space-sm: 8px`
    - `--space-md: 16px`
    - `--space-lg: 24px`
    - `--space-xl: 40px`
    - `--space-2xl: 64px`
  - Colors: `--color-primary`, `--color-surface`, `--color-muted`, `--color-accent`
  - Typography: max 2 font families, consistent scale
    - `--text-sm: 0.875rem` (14px)
    - `--text-md: 1rem` (16px)
    - `--text-lg: 1.125rem` (18px)
    - `--text-xl: 1.25rem` (20px)
    - `--text-2xl: 1.5rem` (24px)
    - `--text-display: 2.5rem` (40px)
    - `--leading-tight: 1.2`
    - `--leading-normal: 1.5`
    - `--leading-relaxed: 1.75`
    - `--font-regular: 400`
    - `--font-medium: 500`
    - `--font-bold: 700`
  - Radius: `--radius-sm`, `--radius-md`, `--radius-lg`
- **Semantic color tokens (dark mode ready):**
  ```css
  :root {
    --color-bg: var(--color-surface);
    --color-text: oklch(15% 0 0);
    --color-text-muted: oklch(45% 0 0);
    --color-border: oklch(88% 0 0);
  }
  @media (prefers-color-scheme: dark) {
    :root {
      --color-bg: oklch(12% 0 0);
      --color-text: oklch(92% 0 0);
      --color-text-muted: oklch(65% 0 0);
      --color-border: oklch(25% 0 0);
    }
  }
  ```
- **Font loading:**
  - Add `<link rel="preconnect">` before font imports
  - Use `font-display: swap` on all `@font-face`
  - Define fallback font stack for each custom font

### Assemble (ANF: A)
- Read component prompts from `components/*.txt` (from 21st.dev "Copy Prompt" workflow)
- Implement each as a semantic `<section id="...">` element
- If no prompts exist: generate sections using taste skill principles
- All values via CSS custom properties — zero hard-coded colors/sizes

**ARIA Landmarks (required):**
- Wrap page with: `<header>`, `<main>`, `<nav>`, `<footer>`
- Every section gets `role="region"` with `aria-label` if no heading
- Example structure:
  ```html
  <header>...</header>
  <nav aria-label="Main navigation">...</nav>
  <main>
    <section aria-labelledby="hero-heading">...</section>
  </main>
  <footer>...</footer>
  ```

**Image & Video Rules (required for CLS prevention):**
- Always include `width` and `height` attributes on `<img>` and `<video>`
- Use `aspect-ratio` CSS to maintain proportions
- Hero images: add `fetchpriority="high"` and `<link rel="preload" as="image">`
  Example: `<link rel="preload" as="image" href="hero.webp" fetchpriority="high">`

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

**Color Contrast (WCAG 2.1 AA required):**
- Text on background: minimum 4.5:1 ratio
- Large text (18px+): minimum 3:1 ratio
- Verify with: https://webaim.org/resources/contrastchecker/
- Use `oklch()` for perceptually uniform color adjustments

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
- **Alt Text Rules (required for accessibility):**
  - Informative images: descriptive alt (max 125 chars)
    Example: `alt="Dashboard showing monthly revenue trend, up 23%"`
  - Decorative images: `alt=""` (empty, not missing)
  - Logo: `alt="[Company name] logo"`
  - CTA images: describe the action
  - AI-generated: describe subject + mood, never "AI generated image"

### Polish
**Motion Safety (required):**
Always wrap animations in motion check:
```css
@media (prefers-reduced-motion: no-preference) {
  /* animations here */
}
/* OR add at end of stylesheet: */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

- **Hero video:** `<video autoplay loop muted playsinline>`, `object-fit: cover`, gradient mask
  ```html
  <video autoplay loop muted playsinline>
    <source src="hero.webm" type="video/webm">
    <source src="hero.mp4" type="video/mp4">
  </video>
  ```
- **Scroll animation:** IntersectionObserver + requestAnimationFrame, or CSS `animation-timeline: scroll()`
- **Frame sequence:** If `assets/frames/` exists, build scroll-driven frame swap
- **Video compress:**
  ```bash
  ffmpeg -i input.mp4 -vcodec libx264 -crf 28 -movflags +faststart output.mp4
  ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 35 -b:v 0 output.webm
  ```
- **GIF creation:** `ffmpeg -i video.mp4 -vf "fps=15,scale=480:-1" output.gif`
- **Deploy workflow:**
  1. `npx netlify-cli deploy --dir=.` (preview deploy)
  2. Review the preview URL
  3. Confirm: "Deploy to production? (y/N)"
  4. `npx netlify-cli deploy --prod --dir=.`
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
