# television

A TUI picker for everything — files, processes, SSH hosts, and more. Powered by [television](https://github.com/alexpdp7/television).

## Quick Start

Run `tv` to open the default **files** channel. Or press `Ctrl+T` in your shell for smart autocomplete.

## Cable Channels

Custom channels live in `cable/`. Each defines a data source, preview command, and optional actions.

| Channel             | Description                                                          | Trigger                                            |
| ------------------- | -------------------------------------------------------------------- | -------------------------------------------------- |
| **ssh-hosts**       | Browse and connect to SSH hosts from `~/.ssh/config`                 | `ssh`, `scp`, `rsync` + `Ctrl+T`                   |
| **systemd-units**   | List and manage systemd services (start/stop/restart/enable/disable) | `systemctl` + `Ctrl+T`                             |
| **procs**           | Find and manage running processes (kill/terminate)                   | —                                                  |
| **zsh-history**     | Search and execute commands from your zsh history                    | `Ctrl+R`                                           |
| **man-pages**       | Browse and preview system manual pages                               | `man` + `Ctrl+T`                                   |
| **pacman-packages** | List installed packages, remove them, or view their files            | `pacman -R`, `pacman -Qi`, `pacman -Ql` + `Ctrl+T` |
| **sesh**            | Switch tmux sessions via [sesh](https://github.com/joshmedeski/sesh) | —                                                  |

## Keybindings

| Key                  | Action                                     |
| -------------------- | ------------------------------------------ |
| `Ctrl+T`             | Smart autocomplete (shell integration)     |
| `Ctrl+R`             | Command history                            |
| `Ctrl+T` (in shell)  | Trigger tv for the current command context |
| `Ctrl+O`             | Toggle preview panel                       |
| `Ctrl+Y`             | Copy selected entry to clipboard           |
| `Ctrl+R` (inside tv) | Reload source                              |
| `Esc`                | Quit                                       |

## Shell Integration

The config maps shell commands to channels via `channel_triggers` in `config.toml`. When you type a tracked command (e.g. `git checkout`) and press `Ctrl+T`, television opens with the matching channel pre-loaded.

## Adding a Channel

1. Create a new `.toml` file in `cable/`
2. Define a `[source]` command that outputs lines
3. Optionally add a `[preview]` command using `{}` as the selected entry placeholder
4. Optionally define `[actions.*]` for custom keybindings

See existing channels in `cable/` for examples.
