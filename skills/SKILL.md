---
name: frontend-craft
description: "ANF frontend pipeline — high-end site/app build. Triggers: frontend craft, frontend pipeline, ANF, high-end site, web craft, premium frontend, build me a site, build a landing page, add a page, fix the design"
argument-hint: "[start|setup|assemble|normalize|fill|polish|add|fix]"
user-invocable: true
---

# /frontend-craft — High-End Frontend Pipeline

Builds $5-10K quality websites and applications. Works on **new or existing** projects. Handles anything from a single section to a full product site.

---

## Entry Point

```
/frontend-craft          → Interview + build
/frontend-craft help     → Show command reference
```

---

## help

When `/frontend-craft help` is called, print this exactly:

```
╔══════════════════════════════════════════════════╗
║          /frontend-craft — Quick Reference       ║
╠══════════════════════════════════════════════════╣
║  /frontend-craft          Start interview + build ║
║  /frontend-craft help     Show this reference     ║
╠══════════════════════════════════════════════════╣
║  PHASES (run manually if needed)                 ║
║  /frontend-craft setup    Scaffold + tokens       ║
║  /frontend-craft assemble Build sections          ║
║  /frontend-craft normalize Unify design system    ║
║  /frontend-craft fill     Real copy + assets      ║
║  /frontend-craft polish   Animations + deploy     ║
╠══════════════════════════════════════════════════╣
║  SHORTCUTS                                       ║
║  /frontend-craft add      Add page/section/feature║
║  /frontend-craft fix      Fix/redesign something  ║
╠══════════════════════════════════════════════════╣
║  FILE LAYOUT (after setup)                       ║
║  index.html               Main entry             ║
║  src/styles.css           Design tokens + global  ║
║  src/main.js              JS interactions         ║
║  components/              Section HTML files      ║
║  assets/                  Images, video, research ║
║  craft-brief.md           Project brief           ║
╚══════════════════════════════════════════════════╝
```

---

## Phase 0 — Interview (ALWAYS FIRST)

Before touching any file, ask ALL questions in a single message. Never ask one at a time.

### Step 1: Detect context silently

Scan the current directory (Glob, Read):
- Existing project? (package.json, index.html, src/, app/, pubspec.yaml)
- Stack? (React, Next.js, vanilla, Astro, Flutter)
- Existing design system? (CSS variables, Tailwind config)
- Existing copy / brand info?

### Step 2: One question at a time — with lettered options

Ask questions **one by one**. Each question is a separate message. Wait for the answer, then ask the next automatically. Do NOT ask multiple questions in one message. Skip questions already answered by context.

**Question sequence:**

Q1:
```
Bu ne? (bir cümle — ürün, servis veya amaç)
```
→ Wait for answer. Then:

Q2:
```
Kime yönelik?
  a) B2C — bireysel kullanıcı
  b) B2B — şirketler
  c) Geliştirici / teknik kitle
  d) Genel / karma
  e) Diğer → yaz
```
→ Wait. Then:

Q3:
```
Ne lazım?
  a) Tam site (landing + birden fazla sayfa)
  b) Sadece landing page
  c) Belirli bir sayfa → hangisi?
  d) Mevcut siteye ekleme → ne?
  e) Küçük bir şeyi düzelt → ne?
```
→ Wait. Then:

Q4:
```
Stil?
  a) Minimal & clean
  b) Bold & güçlü
  c) Editorial & magazine
  d) Kurumsal & güven veren
  e) Dark mode ağırlıklı
  f) Oyuncu & enerjik
  g) Diğer → yaz
```
→ Wait. Then:

Q5:
```
Renkler?
  a) Marka rengim var → hex yaz
  b) Sen seç (stilden çıkar)
```
→ Wait. Then:

Q6:
```
Özellik lazım mı?
  a) Contact form
  b) Pricing tablosu
  c) Newsletter kaydı
  d) Blog / içerik alanı
  e) Auth UI (login/signup)
  f) Dashboard shell
  g) Yok, sadece statik
  (birden fazla seçebilirsin, örn: a c)
```
→ Wait. Then:

Q7:
```
Stack?
  a) Vanilla HTML/CSS/JS
  b) Next.js
  c) Astro
  d) Ne önerirsen
  e) Diğer → yaz
```
→ Wait for final answer.

### Step 3: Build brief

After answers, write `craft-brief.md` in project root. Then show a **file plan** before creating anything:

```
Anlıyorum. İşte yapacaklarım:

📁 Dosya yapısı:
├── index.html              → Ana sayfa (hero + features + CTA + footer)
├── src/
│   ├── styles.css          → Design tokens + global styles
│   └── main.js             → Scroll animasyonları, form handling
├── components/
│   ├── hero.html           → Hero section
│   ├── features.html       → Özellikler grid
│   └── footer.html         → Footer
├── assets/
│   ├── research.json       → Ürün araştırması (Fill fazında)
│   └── demo/               → Görseller buraya
└── craft-brief.md          → Proje brief'i

🎨 Stil: [seçilen stil]
🎯 Scope: [ne yapılacak]
⚡ Stack: [seçilen stack]

Başlayayım mı? (y / değiştir)
```

Show plan. Wait for ONE final confirmation ("y" or "değiştir").

**If "y":** Execute the entire pipeline to completion. No more questions. No pauses. No "shall I continue?" between phases. Run straight through to the end.

**If "değiştir":** User edits specific parts inline → update plan → re-confirm → then execute fully.

### Step 3: Build a brief

After the user answers, write `craft-brief.md` in the project root:

```markdown
# [Project Name] — Craft Brief
> Created: [date]

## What
[One sentence]

## Who
[Target audience]

## Scope
[Exact deliverables — pages, sections, features]

## Style
[Direction + colors]

## Stack
[Chosen tech]

## Must-haves
[Feature list]

## Existing project
[What was found, what to keep, what to replace]
```

Show the brief to the user. Ask: **"Good to go? (y / adjust)"**

If adjust: let them correct inline, update the brief, re-confirm.

If yes: proceed to execution.

---

## Phase 1 — Scope Router

Based on the brief, choose the execution path:

| Scope | Path |
|-------|------|
| Single section or fix | → [Targeted Mode](#targeted-mode) |
| Single page | → Setup + Assemble + Normalize + Fill |
| Full site | → Full ANF + Polish |
| Add to existing | → [Addon Mode](#addon-mode) |
| Feature (form, auth, etc.) | → [Feature Mode](#feature-mode) |

---

## Targeted Mode

For small requests ("fix the hero", "add a pricing section", "redesign the nav"):

1. Read the existing file(s)
2. Understand the current design system (extract variables if any)
3. Make the targeted change — nothing else
4. Apply Normalize rules to the changed section only
5. Fill with real copy if placeholder text is present

---

## Addon Mode

For adding to an existing project:

1. Read the project structure
2. Identify: routing system, component pattern, CSS approach
3. Create the new page/section following existing conventions
4. Do not change files that weren't asked about
5. Apply Fill phase only to new content

---

## Feature Mode

For functional additions (contact form, pricing, newsletter, auth UI, dashboard, etc.):

1. Build the UI component with real functionality
2. **Contact form:** HTML form + Netlify Forms (`netlify` attribute) or Formspree endpoint
3. **Pricing table:** tier comparison, CTA per tier, annual/monthly toggle
4. **Newsletter:** input + submit + success state (integrate Buttondown or Mailchimp embed)
5. **Auth UI:** login + signup forms, forgot password flow (UI only unless stack supports it)
6. **Dashboard shell:** sidebar nav, header, main content area, responsive
7. Wire up interactions in vanilla JS or the project's framework
8. Apply all accessibility rules (ARIA, keyboard nav, labels)

---

## Full ANF Pipeline

### Setup

**Only for new projects or when explicitly asked to scaffold.**

- Create folder structure: `src/`, `assets/`, `components/`, `public/`
- Install dependencies based on chosen stack
- Define CSS custom properties:

**Spacing (8px grid):**
```css
--space-xs: 4px;
--space-sm: 8px;
--space-md: 16px;
--space-lg: 24px;
--space-xl: 40px;
--space-2xl: 64px;
```

**Typography:**
```css
--text-sm: 0.875rem;    /* 14px */
--text-md: 1rem;        /* 16px */
--text-lg: 1.125rem;    /* 18px */
--text-xl: 1.25rem;     /* 20px */
--text-2xl: 1.5rem;     /* 24px */
--text-display: 2.5rem; /* 40px */
--leading-tight: 1.2;
--leading-normal: 1.5;
--leading-relaxed: 1.75;
--font-regular: 400;
--font-medium: 500;
--font-bold: 700;
```

**Colors (4-role system):**
```css
--color-primary: [from brief];
--color-surface: [from brief];
--color-muted: [from brief];
--color-accent: [from brief];
```

**Semantic tokens (dark mode ready):**
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

**Other tokens:**
```css
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 16px;
--shadow-soft: 0 2px 8px rgba(0,0,0,.06);
--shadow-medium: 0 4px 24px rgba(0,0,0,.10);
--shadow-strong: 0 8px 48px rgba(0,0,0,.18);
--ease-default: cubic-bezier(.4,0,.2,1);
--duration-fast: 150ms;
--duration-normal: 250ms;
--duration-slow: 400ms;
```

**Font loading:**
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
```
```css
@font-face {
  font-display: swap;
  /* define fallback stack */
}
```

**taste-skill:** Reference https://github.com/Leonxlnx/taste-skill/tree/main for design principles. Pin to a specific commit SHA before use.

---

### Assemble (ANF: A)

- Read component prompts from `components/*.txt` if they exist
- Otherwise generate sections from the brief: hero, features, social proof, CTA, footer
- Every section is a semantic `<section id="...">` element

**ARIA Landmarks (required):**
```html
<header>...</header>
<nav aria-label="Main navigation">...</nav>
<main>
  <section aria-labelledby="hero-heading">...</section>
  <section aria-labelledby="features-heading">...</section>
</main>
<footer>...</footer>
```
Every section without a visible heading gets `role="region" aria-label="..."`.

**Image & Video (required for CLS):**
- Always set `width` and `height` on `<img>` and `<video>`
- Use `aspect-ratio` CSS
- Hero image preload:
```html
<link rel="preload" as="image" href="hero.webp" fetchpriority="high">
<img src="hero.webp" width="1440" height="800" fetchpriority="high" alt="...">
```

**21st.dev workflow (optional):**
1. Browse https://21st.dev
2. "Copy Prompt" → "Claude Code"
3. Save as `components/01.txt`, `02.txt`, etc.

---

### Normalize (ANF: N)

Replace all hard-coded values with CSS custom properties:
- Spacing → `--space-*`
- Typography → `--text-*`, `--leading-*`, `--font-*`
- Colors → `--color-*` (4-role system)
- Buttons → single border-radius, single hover pattern
- Shadows → `--shadow-soft/medium/strong`
- Motion → `--ease-default`, `--duration-*`
- Purge purple defaults (#6366f1, indigo-500) if present

**WCAG 2.1 AA (required):**
- Text on background: minimum 4.5:1 ratio
- Large text (18px+): minimum 3:1 ratio
- Check: https://webaim.org/resources/contrastchecker/
- Use `oklch()` for perceptually uniform color tweaks

---

### Fill (ANF: F)

1. Read `craft-brief.md` for product context
2. Research (WebSearch): value props, target audience pain points, competitor positioning
3. Write `assets/research.json`
4. Replace all placeholder copy:
   - Headlines: max 8 words
   - Sublines: max 20 words
   - CTAs: max 4 words
   - Banned words: "leverage", "seamless", "revolutionary", "transformative", "cutting-edge"
5. SEO: set `<title>`, `<meta description>`, `<h1>` hierarchy

**Alt text (required):**
- Informative: descriptive, max 125 chars (`alt="Dashboard showing revenue up 23%"`)
- Decorative: `alt=""` (empty, not missing)
- Logo: `alt="[Company name] logo"`
- AI-generated: describe subject + mood — never write "AI generated image"

**Asset generation:**
| Tool | URL | Free | Best for |
|------|-----|------|----------|
| Playground AI | playgroundai.com | 500/day | Hero, section bg |
| Ideogram | ideogram.ai | ~25/day | Text-in-image, logos |
| Higgsfield | higgsfield.ai | 66 credits/day | AI video |

Prompt template: `"High quality [TYPE] for [PRODUCT]. Clean, minimal, premium. No text unless logo."`

---

### Polish

**Motion safety (required — always wrap animations):**
```css
@media (prefers-reduced-motion: no-preference) {
  /* all animations here */
}
```
Or add globally:
```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

**Hero video:**
```html
<video autoplay loop muted playsinline style="object-fit:cover">
  <source src="hero.webm" type="video/webm">
  <source src="hero.mp4" type="video/mp4">
</video>
```

**Video compress:**
```bash
ffmpeg -i input.mp4 -vcodec libx264 -crf 28 -movflags +faststart output.mp4
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 35 -b:v 0 output.webm
```

**Scroll animation:** IntersectionObserver + requestAnimationFrame, or `animation-timeline: scroll()`

**Deploy workflow:**
```bash
# 1. Preview
npx netlify-cli deploy --dir=.
# 2. Review preview URL
# 3. Confirm prod deploy with user
npx netlify-cli deploy --prod --dir=.
```

**Verify:** Lighthouse audit, target 90+ on all metrics.

---

## Design Rules

**Anti-patterns (never do):**
- Hard-coded `indigo-500` or purple as default brand color
- Generic card grid for every section
- Inter on everything
- Symmetric, template-looking layouts
- Gradient blob + floating mockup hero

**Principles (always follow):**
- Asymmetric layouts with editorial spacing
- Strong typographic hierarchy (2 font families max)
- Intentional whitespace — let content breathe
- Each section feels uniquely composed
- Consistent rhythm, not monotonous repetition

---

## Execution Rules

- **Never ask mid-task.** All questions happen in Phase 0. After confirmation, execute to completion.
- **Existing projects:** Read first, adapt to what's there. Don't overwrite working code.
- **Small requests:** Don't run the full pipeline. Targeted Mode only.
- **Copy:** Never lorem ipsum in the final output. Research and write real copy.
- **Code:** All values via CSS custom properties — zero hard-coded colors, sizes, or spacing.
