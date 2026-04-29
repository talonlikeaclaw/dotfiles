# Kitty Config

Font: Maple Mono NF 11.5pt | Theme: Catppuccin Mocha | Opacity: 0.97

**Leader:** `ctrl+space` (then key) — like tmux prefix

## Splits (Windows)

| Key             | Action                                  |
| --------------- | --------------------------------------- |
| `leader+\`      | Split right (side by side)              |
| `leader+-`      | Split down (stacked)                    |
| `alt+arrows`    | Navigate splits (no leader)             |
| `leader+h/j/k/l`| Navigate splits (vim-style)            |
| `leader+arrows` | Resize split                            |
| `leader+q`      | Close split                             |
| `leader+z`      | Zoom/unzoom split (toggle stack layout) |

## Tabs

| Key                | Action                  |
| ------------------ | ----------------------- |
| `leader+t`         | New tab (inherits cwd)  |
| `leader+w`         | Close tab               |
| `shift+left/right` | Switch tabs (no leader) |
| `leader+h/l`       | Switch tabs             |
| `leader+r`         | Rename tab              |

## Layouts

Toggle zoom with `leader+z` (stack/splits). Available: `splits`, `stack`, `tall`, `fat`, `grid`.

## Sessions

Startup session: `sessions/mainframe.conf` — opens one tab named "mainframe" in splits layout.

To launch a specific session: `kitty --session ~/.config/kitty/sessions/<name>.conf`

## Kittens & Tools

| Key          | Action                                        |
| ------------ | --------------------------------------------- |
| `leader+p`   | Hints — pick URL/path/hash from output        |
| `leader+u`   | Hints — open URL in browser                   |
| `leader+s`   | Open scrollback in nvim (read-only)           |
| `leader+b`   | Broadcast — type in all splits simultaneously |

SSH: `ssh` aliased to `kitten ssh` — preserves kitty graphics/colors on remote.

Remote control enabled (`unix:/tmp/kitty`): use `kitten @` to script kitty from shell.

## Misc

| Key                  | Action            |
| -------------------- | ----------------- |
| `leader+f5`          | Reload config     |
| `ctrl+shift+c/v`     | Copy / Paste      |
| `ctrl+shift+up/down` | Scroll            |
| `ctrl+shift+f`       | Search scrollback |
