# GNU Stow Cross-Platform Dotfiles Design

**Date:** 2026-04-06  
**Status:** Approved

## Goal

Restructure the dotfiles repo to use GNU Stow for symlink management and consolidate macOS and EndeavourOS configs into a single branch with a shared + platform-specific package model.

## Context

The current repo uses manual whole-directory symlinks (e.g., `~/.config/fish -> ~/.dotfiles/fish`). Platform variants are maintained across separate branches (`main`/`endeavour` for Linux, `macbook` for macOS), which have drifted out of sync. The goal is to eliminate the branch-per-platform model and the manual linking in favor of Stow packages and a single `main` branch.

## Repository Structure

```
~/.dotfiles/
├── archive/            # Configs kept but never stowed (fish, zellij)
│   ├── fish/
│   └── zellij/
│
├── bat/                # Shared Stow packages (stowed on all platforms)
│   └── .config/bat/
├── fastfetch/
│   └── .config/fastfetch/
├── ghostty/            # Shared base config
│   └── .config/ghostty/
├── ghostty-linux/      # Linux-only additions or overrides
│   └── .config/ghostty/
├── ghostty-mac/        # macOS-only additions or overrides
│   └── .config/ghostty/
├── gitmux/
│   └── .gitmux.conf
├── helix/
│   └── .config/helix/
├── kitty/
│   └── .config/kitty/
├── nvim/
│   └── .config/nvim/
├── starship/
│   └── .config/starship.toml
├── tmux/
│   └── .config/tmux/
├── zed/
│   └── .config/zed/
├── zsh/
│   └── .zshrc
│
└── install.sh
```

Each package mirrors the target directory tree rooted at `$HOME`, so Stow creates file-level symlinks rather than directory-level ones.

## Platform-Specific Package Strategy

- **Shared package** (e.g., `ghostty/`) holds all config common to both platforms.
- **Platform package** (e.g., `ghostty-linux/`, `ghostty-mac/`) holds only the differing files.
- Stow merges both packages into the same target directory. A single file may only come from one package — if a file differs entirely between platforms, it lives in the platform packages only, not in the shared one.
- Platform packages are created on demand — only when an actual difference is found. The initial migration starts with everything in shared packages.

## Bootstrap Script (`install.sh`)

```sh
#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.dotfiles"
OS=$(uname)

SHARED=(bat fastfetch ghostty gitmux helix kitty nvim starship tmux zed zsh)

if [[ "$OS" == "Darwin" ]]; then
    PLATFORM=(ghostty-mac)
elif [[ "$OS" == "Linux" ]]; then
    PLATFORM=(ghostty-linux)
fi

cd "$DOTFILES"

for pkg in "${SHARED[@]}" "${PLATFORM[@]}"; do
    stow -R --target="$HOME" "$pkg"
done
```

- Uses `stow -R` (restow) so the script is safe to re-run — existing links are removed and recreated cleanly.
- `PLATFORM` arrays start minimal and grow as platform-specific packages are added.
- `archive/` is never referenced in the script.

## Migration Plan

1. Remove existing whole-directory symlinks from `~/.config/` and `~/`.
2. Restructure each package directory to mirror the target path (e.g., `fish/` becomes `fish/.config/fish/`).
3. Move `fish/` and `zellij/` into `archive/`.
4. Reconcile the `macbook` branch — diff it against `main` and move only the truly differing files into platform-specific packages.
5. Collapse to a single `main` branch.
6. Run `install.sh` to stow all packages.

## What Is Not Changing

- The set of tools being configured (bat, fastfetch, ghostty, gitmux, helix, kitty, nvim, starship, tmux, zed, zsh).
- The content of any config files — this is purely a structural and tooling change.
