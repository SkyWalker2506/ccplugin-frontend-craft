# ccplugin-frontend-craft

Claude Code plugin for building high-end frontend sites and applications using the ANF (Assemble → Normalize → Fill) + Polish pipeline.

## What it does

Provides the `/frontend-craft` skill for Claude Code sessions. This skill guides the AI through a structured pipeline that produces premium-quality websites — the kind that look like they cost $5-10K from a design studio.

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
