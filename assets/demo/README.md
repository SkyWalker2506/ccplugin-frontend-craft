# Demo Assets

Place demo recordings here.

## Required

- `demo.gif` — Screen recording of the ANF pipeline in action
  - Suggested flow: `/frontend-craft setup` → `/frontend-craft assemble` → result
  - Target: 15-30 seconds, 480px wide, 15fps
  - Record with: QuickTime → ffmpeg: `ffmpeg -i recording.mov -vf "fps=15,scale=480:-1" demo.gif`

- `screenshot.png` — Before/after or final site output (optional)
