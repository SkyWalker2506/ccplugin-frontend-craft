# ccplugin-frontend-craft

![claude-code](https://img.shields.io/badge/claude--code-plugin-black?style=flat-square)
![frontend](https://img.shields.io/badge/frontend-pipeline-blue?style=flat-square)
![ai-tools](https://img.shields.io/badge/ai--tools-ANF-purple?style=flat-square)
![plugin](https://img.shields.io/badge/plugin-open--source-green?style=flat-square)

Claude Code plugin for building high-end frontend sites and applications using the ANF (Assemble → Normalize → Fill) + Polish pipeline.

## What it does

Provides the `/frontend-craft` skill for Claude Code sessions. This skill guides the AI through a structured pipeline that produces premium-quality websites — the kind that look like they cost $5-10K from a design studio.

---

![Demo](assets/demo/demo.gif)

---

## Why ANF?

Most AI site builders (v0, Bolt, Lovable) generate something that looks fine in a screenshot. ANF goes further:

- **Coherent design system, not random components.** The Normalize phase unifies every CSS token across the entire site — no more mismatched font sizes, inconsistent spacing, or color drift between sections.
- **Real content, not lorem ipsum.** The Fill phase researches your actual product, writes copy that converts, and generates on-brand visuals — so the site is launch-ready, not demo-ready.
- **Taste-driven, not template-driven.** ANF loads a curated design taste skill before generating anything. Every decision — spacing rhythm, motion, typography — is filtered through high-end design principles rather than defaults.

## Perfect for

- Indie hackers launching a product landing page fast
- Freelancers who need agency-quality output without agency overhead
- Startups that want a polished web presence before hiring a designer
- Developers who know code but want structured AI help with design decisions

## What you get

- Fully scaffolded project (Next.js, Astro, or vanilla) with a working build
- Design token file (`tokens.css`) with a unified custom property system
- Section-by-section components sourced from [21st.dev](https://21st.dev) prompts
- Real copy written for your product — no placeholders
- AI-generated hero images and open graph assets
- Scroll animations, entrance effects, and video integration
- One-command deploy to Netlify CDN

## Pipeline

| Phase | Description |
|-------|-------------|
| **Setup** | Scaffold project, configure design tokens, load taste skill |
| **Assemble** | Build sections from 21st.dev component prompts |
| **Normalize** | Unify the design system with CSS custom properties |
| **Fill** | Research product, write real copy, generate AI assets |
| **Polish** | Add animations, video, scroll effects, and deploy |

## Installation

```bash
./install.sh
```

This copies the skill to `~/.claude/skills/frontend-craft/SKILL.md`.

## Usage

### With ClaudeHQ sprint system
```bash
hq frontend MyProject --stack vanilla
hq dispatch MyProject
```

### Standalone in any project
```
/frontend-craft setup
/frontend-craft assemble
/frontend-craft normalize
/frontend-craft fill
/frontend-craft polish
```

## Uninstall

```bash
./uninstall.sh
```

## References

- [Leon's Taste Skill](https://github.com/Leonxlnx/taste-skill) — Design principles
- [21st.dev](https://21st.dev) — Designer-quality components
- [Playground AI](https://playgroundai.com) — Free image generation (500/day)
- [Ideogram](https://ideogram.ai) — Text-in-image generation
- [Netlify](https://netlify.com) — Free CDN hosting
