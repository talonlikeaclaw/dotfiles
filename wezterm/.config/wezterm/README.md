# Wezterm Configuration

Personal Wezterm terminal emulator configuration using the Catppuccin Mocha color scheme.

## Setup

Stowed via GNU Stow as part of the dotfiles setup:

```bash
./install.sh
```

Requires the font **Maple Mono NF** to be installed.

## Keybindings

### Leader Key

`Ctrl+Space` — Activate leader (2s timeout)

### Pane Management

| Binding            | Action                     |
| ------------------ | -------------------------- |
| `Leader + \`       | Split horizontal           |
| `Leader + -`       | Split vertical             |
| `Leader + h/j/k/l` | Navigate panes (vim-style) |
| `Alt + Arrow`      | Navigate panes (arrows)    |
| `Leader + Arrow`   | Resize pane (5 units)      |
| `Leader + z`       | Toggle pane zoom           |

### Tabs

| Binding              | Action                |
| -------------------- | --------------------- |
| `Leader + t`         | New tab               |
| `Leader + w`         | Close tab (no prompt) |
| `Shift + Left/Right` | Previous/next tab     |
| `Leader + [/]`       | Previous/next tab     |
| `Leader + r`         | Rename tab            |

### Other

| Binding               | Action                          |
| --------------------- | ------------------------------- |
| `Leader + q`          | Close pane (no prompt)          |
| `Leader + c`          | Enter copy mode                 |
| `Leader + u`          | Search                          |
| `Leader + s`          | Open stdin in nvim (new window) |
| `Leader + b`          | Broadcast input to all panes    |
| `Leader + F5`         | Reload config                   |
| `Leader + Ctrl+Space` | Pass `Ctrl+Space` to shell      |

### Sessions

| Binding            | Action                          |
| ------------------ | ------------------------------- |
| `Leader + n`       | New workspace (prompt for name) |
| `Leader + S`       | Save session                    |
| `Leader + o`       | Load session (fuzzy picker)     |
| `Leader + R`       | Restore session (current ws)    |
| `Leader + f`       | Fork session (duplicate layout) |
| `Leader + D`       | Delete session                  |
| `Leader + E`       | Edit session (opens JSON)       |
| `Leader + a`       | Toggle auto-save                |

### Copy Mode

All default navigation keys apply (vim-style + arrows). Custom additions:

| Binding        | Action            |
| -------------- | ----------------- |
| `Escape` / `q` | Exit copy mode    |
| `v`            | Cell selection    |
| `y`            | Copy to clipboard |

### Mouse

| Binding             | Action              |
| ------------------- | ------------------- |
| Left click release  | Primary selection   |
| `Ctrl + Left click` | Open link at cursor |

## Features

- **Color scheme**: Catppuccin Mocha with custom tab bar colors
- **Font**: Maple Mono NF at 11.5pt
- **Scrollback**: 10,000 lines (scrollbar hidden)
- **Cursor**: Blinking block, no blink rate
- **Window**: 97% opacity, 4px padding, no close confirmation
- **Wayland**: Enabled
- **Shell**: zsh login shell

## Plugins

- **wezterm-sessions** ([abidibo/wezterm-sessions](https://github.com/abidibo/wezterm-sessions)): Save/load/restore/fork/delete sessions. Auto-saves every 30s. Sessions are workspace-based — `load` opens a fuzzy picker to browse all saved sessions, `restore` matches the current workspace name. State files are JSON and can be edited via `Leader + E`.

## Status Bar

- **Right**: Shows "LEADER" when leader key is active
- **Tab titles**: Formatted as `N: <custom-or-pane-title>`, truncated to 32 chars
- **Tab bar**: Fancy style, positioned at top
