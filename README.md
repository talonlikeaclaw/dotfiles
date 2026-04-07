# Talon's Dotfiles

Personal configuration files for macOS and EndeavourOS (Arch), managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/talonlikeaclaw/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` detects the OS and stows the right packages automatically.

## Structure

Each tool is a Stow package that mirrors the target directory tree from `$HOME`. Running `./install.sh` creates the appropriate symlinks.

### Shared packages (all platforms)

| Package | Description |
|---|---|
| `bat` | `cat` replacement |
| `fastfetch` | System info display |
| `ghostty` | GPU-accelerated terminal emulator |
| `gitmux` | Git status in tmux status bar |
| `helix` | Modal text editor written in Rust |
| `kitty` | Terminal emulator |
| `nvim` | Neovim config |
| `starship` | Shell prompt |
| `tmux` | Terminal multiplexer |

### Platform-specific packages

| Package | Platform | Description |
|---|---|---|
| `zsh` | Linux | Zsh config |
| `zed` | Linux | Zed editor config |
| `zsh-mac` | macOS | Zsh config |
| `zed-mac` | macOS | Zed editor config |
| `aerospace` | macOS | Tiling window manager |

### Archived (not stowed)

Configs kept for reference in `archive/`: `fish`, `zellij`

## Adding a new package

1. Create a directory mirroring the target path, e.g. `myapp/.config/myapp/`
2. Put your config files inside
3. Add the package name to the appropriate array in `install.sh`
4. Run `./install.sh`

## Adding platform-specific config

Create a `myapp-mac/` or `myapp-linux/` package with only the differing files, add it to the `PLATFORM` array in `install.sh`.
