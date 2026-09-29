# Talon's Dotfiles

Personal configuration files for macOS and EndeavourOS (Arch), managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/talonlikeaclaw/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` detects the OS, initializes git submodules (TPM and the Oh My Pi skill sources), and stows the shared packages plus the matching platform set.

Re-stow a single package after moving files around:

```bash
stow -R --target="$HOME" <pkg>   # refresh symlinks
stow -D --target="$HOME" <pkg>   # remove symlinks
```

## Structure

Each tool is a Stow package that mirrors the target directory tree from `$HOME`. The package lists live in the `SHARED` and `PLATFORM` arrays of `install.sh`.

### Shared packages (all platforms)

| Package | Description |
|---|---|
| `bat` | `cat` replacement |
| `fastfetch` | System info display |
| `git` | `~/.gitconfig` (identity, `main` default branch) |
| `ghostty` | GPU-accelerated terminal emulator |
| `gitmux` | Git status in tmux status bar |
| `helix` | Modal text editor written in Rust |
| `herdr` | Terminal workspace manager (`prefix` = `ctrl+b`) |
| `kitty` | Terminal emulator with per-project session files |
| `nvim` | Neovim config (pack-based `lua/`, LSP, indent) |
| `omp` | Oh My Pi coding-agent config (`~/.omp/agent`) |
| `opencode` | OpenCode coding-agent config, skills, TUI |
| `starship` | Shell prompt |
| `television` | Fuzzy finder with custom `cable/` channels (sesh, pacman, ssh-hosts, systemd-units, zsh-history, …) |
| `tmux` | Terminal multiplexer (TPM plugins via submodule) |

Both `omp` and `opencode` keep their skills under the package (`omp/.omp/agent/skills`, `opencode/.config/opencode/skills`); Oh My Pi skills are pinned as git submodules so `./install.sh` fetches them.

### Linux-only packages

| Package | Description |
|---|---|
| `llama-swap` | Local llama.cpp model server (systemd-managed, `127.0.0.1:11434`) |
| `niri` | Scrollable-tiling Wayland compositor; spawns `noctalia` at startup and `wezterm` on `Mod+T` |
| `noctalia` | Wayland desktop shell (bar, launcher, control center) |
| `wezterm` | Terminal emulator with per-project session files |
| `zed` | Zed editor config (settings, keymap, tasks, themes) |
| `zsh` | Zsh config |

### macOS-only packages

| Package | Description |
|---|---|
| `aerospace` | Tiling window manager |
| `karabiner-mac` | Karabiner-Elements complex modifications (arrow remaps) |
| `llama-swap-mac` | Local llama.cpp model server binding the same models on Apple silicon |
| `little-coder-mac` | Local coding-agent model registry pointing at MTPLX |
| `wezterm-mac` | Terminal emulator with per-project session files |
| `zed-mac` | Zed editor config (settings, keymap) |
| `zsh-mac` | macOS Zsh config (Homebrew/dotnet/Java paths, `OLLAMA_HOST`) |

`zsh`/`zsh-mac`, `zed`/`zed-mac`, `wezterm`/`wezterm-mac`, and `llama-swap`/`llama-swap-mac` are platform variants of the same tool: only stow the pair member for the current OS (the `-mac` variants must never be stowed alongside their counterparts).

### Legacy (in repo, not installed by `install.sh`)

| Package | Status |
|---|---|
| `ironbar` | Wayland bar config, superseded by `noctalia` |
| `rofi` | Launcher/theming; `noctalia` now provides the launcher on niri |
| `archive/` | Archived `fish`, `zellij`, and `crush` configs kept for reference |

The Wayland bar/launcher pieces may still be stowed on machines that predate `noctalia`; both are absent from the `install.sh` arrays, so they are not set up on a fresh install.

## Local AI / model endpoints

`llama-swap` runs `llama-server` on both hosts with the same model IDs (`qwen3.6-35b`, `qwen3.6-35b-mtp`, …); the macOS variant differs only in the model paths and GPU offload flags.

| Endpoint | Served by | Consumed by |
|---|---|---|
| `127.0.0.1:11434` | `llama-swap` / `llama-swap-mac` | local agents |
| `100.102.253.122:8080` | `llama-mac` over Tailscale | Oh My Pi provider `llama-mac` (`kat-coder`) |
| `100.114.241.90:8080` | `llama-arch` over Tailscale | Oh My Pi provider `llama-arch` (`kat-coder`, `ornith-1.5-35b-a3b`) |
| `127.0.0.1:8000/v1` | MTPLX | `little-coder` |

Oh My Pi (`omp/.omp/agent/`) holds the provider and model-role map (`models.yml`, `config.yml`: `slow`, `web`, `judge`, `default`, `smol`, `vision`), MCP servers (`mcp.json`), and skills.

### Little Coder (macOS)

The macOS-only Stow package targets MTPLX at `http://127.0.0.1:8000/v1`. Start the local server with `mtplx start` (or the MTPLX app), then run `little-coder` or `little-coder --model mtplx/mtplx-qwen36-35b-a3b-optimized-speed`. MTPLX selects the loaded model; update the configured ID if `GET /v1/models` reports a different model. No API key is required.

Verify the server and configured models before launching the agent:

```bash
curl http://127.0.0.1:8000/v1/models
little-coder --list-models
```

## Adding a new package

1. Create a directory mirroring the target path, e.g. `myapp/.config/myapp/`
2. Put your config files inside
3. Add the package name to the appropriate array in `install.sh`
4. Run `./install.sh`

## Adding platform-specific config

Create a `myapp-mac/` or `myapp-linux/` package with only the differing files, add it to the `PLATFORM` array in `install.sh`. Note that `install.sh` currently keeps a single `PLATFORM` array per OS rather than a naming convention — a `-linux` package must be listed in the `Linux` branch explicitly.
