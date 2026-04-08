# Changelog

## [Unreleased]

### Added
- Typography scale tokens with concrete values (`--text-sm` → `--text-display`)
- Spacing scale with px values (`--space-xs: 4px` → `--space-2xl: 64px`)
- Font loading directives: `preconnect` + `font-display: swap`
- Dark mode semantic token layer (`--color-bg`, `--color-text`, `--color-border`)
- ARIA landmark requirements in Assemble phase
- `width`/`height` + `fetchpriority` enforcement for images and video (CLS prevention)
- WCAG 2.1 AA contrast requirements in Normalize phase
- Alt text rules for AI-generated images in Fill phase
- `prefers-reduced-motion` wrapper — mandatory for all Polish phase animations
- WebM output + `-movflags +faststart` to ffmpeg commands
- Netlify 4-step deploy flow (preview → review → confirm → prod)
- taste-skill commit SHA pin guidance

### Changed
- `install.sh`: added `$HOME` guard, symlink check, backup mechanism, `--force` flag
- `uninstall.sh`: added `$HOME` guard, path validation, `rm -rf` confirmation, `--force` flag
- README: added Why ANF value props, target audience, demo placeholder, topic badges
- `plugin.json`: added `dependencies` field (ffmpeg, netlify-cli, jq)

### Security
- `install.sh` now rejects symlink targets to prevent arbitrary file overwrite
- `uninstall.sh` validates `$SKILL_DIR` path before `rm -rf`
- Both scripts guard against empty `$HOME`

## [1.0.0] — 2026-04-07

### Added
- Initial ANF pipeline skill (`/frontend-craft`)
- Setup, Assemble, Normalize, Fill, Polish phases
- Design token system (colors, spacing, radius, motion)
- Anti-pattern list and design principles
- Asset generation tool table (Playground AI, Ideogram, Higgsfield)
- ClaudeHQ sprint integration
