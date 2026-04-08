# Fastfetch Cozy Redesign

**Date:** 2026-04-07
**Status:** Approved

## Goal

Make the fastfetch config more personal and platform-agnostic: an eagle ASCII art logo stacked above a concise info box, a time-aware greeting, Catppuccin colors, no nerd font dependencies, and graceful handling of missing hardware.

## File Structure

```
fastfetch/.config/fastfetch/
├── config.jsonc      ← updated config
└── eagle.txt         ← ASCII eagle art with ${c1}–${c4} color variables
```

Both files are part of the shared `fastfetch` stow package (applies to all platforms).

## Layout

```
[eagle art — stacked top, colored in Catppuccin teal/sky/sapphire/green]

  good evening, talon 🌙
╭──────────── talon ─────────────╮
│  OS      EndeavourOS
│  Uptime  6 days
│  Shell   zsh
│
│  CPU     AMD Ryzen 9 5900X
│  GPU     RTX 3080
│  RAM     16 GB / 32 GB
│  Disk    512 GB / 2 TB
│  ● ● ● ● ● ● ● ● ● ● ● ●
╰────────────────────────────────╯
```

## Config Changes

### Logo

```jsonc
"logo": {
    "type": "file",
    "source": "~/.config/fastfetch/eagle.txt",
    "position": "top",
    "color": {
        "1": "38;2;148;228;213",
        "2": "38;2;137;220;235",
        "3": "38;2;116;199;236",
        "4": "38;2;166;227;161"
    },
    "padding": { "top": 1, "left": 4 }
}
```

Colors map to Catppuccin Mocha: `${c1}` = Teal, `${c2}` = Sky, `${c3}` = Sapphire, `${c4}` = Green.

### Modules

| Module | Change |
|---|---|
| `command` (greeting) | New — time-aware greeting, no key label |
| `title` | Keep, box border color → Catppuccin teal |
| `os` | Keep, remove nerd font glyph |
| `kernel` | **Remove** — redundant with OS for daily use |
| `uptime` | Keep, remove nerd font glyph |
| `shell` | Keep, remove nerd font glyph |
| `cpu` | Keep, remove nerd font glyph |
| `gpu` | Keep, add `"showErrors": false` — disappears if no GPU |
| `memory` | Keep, remove nerd font glyph |
| `disk` | Keep, remove nerd font glyph |
| `colors` | Keep |

### Greeting Command

```bash
h=$(date +%H); if [ $h -lt 12 ]; then echo 'good morning, talon ☀️'; elif [ $h -lt 17 ]; then echo 'good afternoon, talon ☁️'; else echo 'good evening, talon 🌙'; fi
```

Rendered as a `command` module with `"key": " "` (no label).

## Eagle Coloring

`eagle.txt` is annotated with `${c1}`–`${c4}` color variables:

- Lines 1–10 (upper body/wings): `${c1}` — Teal
- Lines 11–20 (mid body): `${c2}` — Sky  
- Lines 21–26 (lower body): `${c3}` — Sapphire
- Lines 27–32 (talons/ground): `${c4}` — Green

Each line is prefixed with the appropriate color variable. Fastfetch resets color at end of logo automatically.

## Platform Agnosticism

- No nerd font glyphs anywhere in keys
- `"showErrors": false` on GPU module — silently hidden on machines without a detectable GPU
- `logo.type: "file"` resolves `~/.config/fastfetch/eagle.txt` via symlink on all platforms
- Works on any terminal that supports UTF-8 box-drawing characters (universal)
- `display.separator` remains `" "` (single space between key and value)
