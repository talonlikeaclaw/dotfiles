# Dotfiles — Agent Notes

## What this repo is

Personal dotfiles for macOS and EndeavourOS (Arch), managed with **GNU Stow**. Each top-level directory is a Stow package that mirrors the target path from `$HOME`.

## Key commands

```bash
./install.sh          # Detect OS, init submodules, stow all packages
stow -R --target="$HOME" <pkg>   # Re-stow a single package
stow -D --target="$HOME" <pkg>   # Unstow a package
git submodule update --init --recursive  # Bootstrap TPM (only submodule)
```

No build, test, lint, or typecheck steps — this is a config-only repo.

## Architecture

- **Shared packages** (all platforms): `bat`, `fastfetch`, `git`, `ghostty`, `gitmux`, `helix`, `kitty`, `nvim`, `opencode`, `starship`, `television`, `tmux`, `wezterm`
- **macOS-only**: `aerospace`, `llama-swap-mac`, `zed-mac`, `zsh-mac`
- **Linux-only**: `llama-swap`, `zed`, `zsh`
- **Archived** (not stowed): `archive/` (fish, zellij configs kept for reference)

Platform logic lives in `install.sh` — `$OS` check against `Darwin`/`Linux`.

## Conventions

- New packages must be added to the `SHARED` or `PLATFORM` arrays in `install.sh`
- Platform variants follow the `<tool>-mac` / `<tool>-linux` naming pattern
- Stow target is always `$HOME`; package dirs must mirror the `~/.config/<tool>/` layout
- TPM plugins in `tmux/.config/tmux/plugins/` are gitignored — installed at runtime via TPM, not committed
- `.opencode/` contains npm dependencies for opencode skills and is gitignored
- `opencode/.config/opencode/` holds OpenCode config (MCP, skills, TUI) — separate from `.opencode/` build artifacts

## Gotchas

- After editing a stowed config, run `stow -R --target="$HOME" <pkg>` to update the symlink; edits to already-symlinked files are live
- `zsh` vs `zsh-mac` are separate Stow packages — never stow both on the same machine
- The `.zshrc` conditionally loads plugins based on `$CONTAINER_ID` — container sessions get a minimal set