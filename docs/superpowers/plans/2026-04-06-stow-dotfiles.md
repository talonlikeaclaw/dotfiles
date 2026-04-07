# GNU Stow Cross-Platform Dotfiles Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure the dotfiles repo to use GNU Stow for symlink management and consolidate all platform configs into a single `main` branch with shared and platform-specific packages.

**Architecture:** Each tool's config becomes a Stow package that mirrors the target directory tree from `$HOME`. Shared configs go in the base package (e.g., `ghostty/`); platform-specific overrides go in companion packages (e.g., `ghostty-mac/`). A bootstrap `install.sh` detects the OS and stows the right combination.

**Tech Stack:** GNU Stow, bash, git

---

## File Map

| Current path | New path | Notes |
|---|---|---|
| `bat/` | `bat/.config/bat/` | contents moved inside |
| `fastfetch/` | `fastfetch/.config/fastfetch/` | contents moved inside |
| `ghostty/` | `ghostty/.config/ghostty/` | shared base |
| `helix/` | `helix/.config/helix/` | contents moved inside |
| `kitty/` | `kitty/.config/kitty/` | contents moved inside |
| `nvim/` | `nvim/.config/nvim/` | contents moved inside |
| `tmux/` | `tmux/.config/tmux/` | contents moved inside |
| `zed/` | `zed/.config/zed/` | `settings_backup.json` deleted |
| `gitmux/gitmux.conf` | `gitmux/.gitmux.conf` | dir restructured |
| `starship.toml` (root) | `starship/.config/starship.toml` | new `starship/` package |
| `.zshrc` (root) | `zsh/.zshrc` | new `zsh/` package |
| `fish/` | `archive/fish/` | archived, not stowed |
| `zellij/` | `archive/zellij/` | archived, not stowed |
| *(macbook only)* `aerospace.toml` | `aerospace/.config/aerospace/aerospace.toml` | mac-only package |
| *(new)* | `install.sh` | bootstrap script |

---

## Task 1: Remove existing manual symlinks

**Files:** none (symlink cleanup only)

- [ ] **Step 1: Remove ~/.config symlinks**

```bash
unlink ~/.config/bat
unlink ~/.config/fastfetch
unlink ~/.config/fish
unlink ~/.config/ghostty
unlink ~/.config/kitty
unlink ~/.config/nvim.bak
unlink ~/.config/tmux
unlink ~/.config/zed
unlink ~/.config/starship.toml
```

- [ ] **Step 2: Remove home-dir symlinks**

```bash
unlink ~/.gitmux.conf
unlink ~/.zshrc
```

- [ ] **Step 3: Verify all target symlinks are gone**

```bash
ls -la ~/.config | grep dotfiles
ls -la ~ | grep dotfiles
```

Expected: no output from either command.

- [ ] **Step 4: Commit**

```bash
cd ~/.dotfiles
git add -A
git commit -m "chore: remove manual symlinks before stow restructure"
```

---

## Task 2: Archive fish and zellij

**Files:**
- Create: `archive/fish/` (moved from `fish/`)
- Create: `archive/zellij/` (moved from `zellij/`)

- [ ] **Step 1: Create archive directory and move packages**

```bash
cd ~/.dotfiles
mkdir archive
git mv fish archive/fish
git mv zellij archive/zellij
```

- [ ] **Step 2: Verify**

```bash
ls archive/
```

Expected: `fish  zellij`

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "chore: archive fish and zellij configs"
```

---

## Task 3: Restructure ~/.config packages to Stow layout

Each package dir gets its contents moved inside a `.config/<name>/` subdirectory so Stow can create the right symlinks in `~/.config/`.

**Files:** bat, fastfetch, ghostty, helix, kitty, nvim, tmux, zed

- [ ] **Step 1: Restructure bat**

```bash
cd ~/.dotfiles
git mv bat bat_old
mkdir -p bat/.config
git mv bat_old bat/.config/bat
```

- [ ] **Step 2: Restructure fastfetch**

```bash
git mv fastfetch fastfetch_old
mkdir -p fastfetch/.config
git mv fastfetch_old fastfetch/.config/fastfetch
```

- [ ] **Step 3: Restructure ghostty**

```bash
git mv ghostty ghostty_old
mkdir -p ghostty/.config
git mv ghostty_old ghostty/.config/ghostty
```

- [ ] **Step 4: Restructure helix**

```bash
git mv helix helix_old
mkdir -p helix/.config
git mv helix_old helix/.config/helix
```

- [ ] **Step 5: Restructure kitty**

```bash
git mv kitty kitty_old
mkdir -p kitty/.config
git mv kitty_old kitty/.config/kitty
```

- [ ] **Step 6: Restructure nvim**

```bash
git mv nvim nvim_old
mkdir -p nvim/.config
git mv nvim_old nvim/.config/nvim
```

- [ ] **Step 7: Restructure tmux**

```bash
git mv tmux tmux_old
mkdir -p tmux/.config
git mv tmux_old tmux/.config/tmux
```

- [ ] **Step 8: Restructure zed (and delete backup file)**

```bash
git mv zed zed_old
mkdir -p zed/.config
git mv zed_old zed/.config/zed
git rm zed/.config/zed/settings_backup.json
```

- [ ] **Step 9: Verify structure of a few packages**

```bash
find bat fastfetch ghostty tmux zed -maxdepth 4 | head -30
```

Expected output (example):
```
bat
bat/.config
bat/.config/bat
bat/.config/bat/config
ghostty
ghostty/.config
ghostty/.config/ghostty
ghostty/.config/ghostty/config
```

- [ ] **Step 10: Commit**

```bash
git add -A
git commit -m "chore: restructure packages to stow layout (.config/* packages)"
```

---

## Task 4: Restructure home-dir packages (gitmux, starship, zsh)

These packages stow files directly into `$HOME`, not `~/.config/`.

**Files:**
- Modify: `gitmux/` → `gitmux/.gitmux.conf`
- Create: `starship/.config/starship.toml`
- Create: `zsh/.zshrc`

- [ ] **Step 1: Restructure gitmux**

```bash
cd ~/.dotfiles
git mv gitmux gitmux_old
mkdir gitmux
git mv gitmux_old/gitmux.conf gitmux/.gitmux.conf
rmdir gitmux_old
```

- [ ] **Step 2: Create starship package**

```bash
mkdir -p starship/.config
git mv starship.toml starship/.config/starship.toml
```

- [ ] **Step 3: Create zsh package**

```bash
mkdir zsh
git mv .zshrc zsh/.zshrc
```

- [ ] **Step 4: Verify**

```bash
find gitmux starship zsh -type f
```

Expected:
```
gitmux/.gitmux.conf
starship/.config/starship.toml
zsh/.zshrc
```

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "chore: restructure home-dir packages (gitmux, starship, zsh)"
```

---

## Task 5: Write install.sh

**Files:**
- Create: `install.sh`

- [ ] **Step 1: Write the script**

Create `~/.dotfiles/install.sh`:

```bash
#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS=$(uname)

SHARED=(bat fastfetch ghostty gitmux helix kitty nvim starship tmux zed zsh)

if [[ "$OS" == "Darwin" ]]; then
    PLATFORM=(ghostty-mac aerospace)
elif [[ "$OS" == "Linux" ]]; then
    PLATFORM=(ghostty-linux)
fi

cd "$DOTFILES"

for pkg in "${SHARED[@]}" "${PLATFORM[@]}"; do
    if [[ -d "$pkg" ]]; then
        echo "Stowing $pkg..."
        stow -R --target="$HOME" "$pkg"
    fi
done

echo "Done."
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x ~/.dotfiles/install.sh
```

- [ ] **Step 3: Commit**

```bash
cd ~/.dotfiles
git add install.sh
git commit -m "feat: add install.sh bootstrap script"
```

---

## Task 6: Dry-run Stow and verify

Use `stow -nv` (simulate, no changes) to confirm the package layout is correct before applying.

- [ ] **Step 1: Dry-run all shared packages**

```bash
cd ~/.dotfiles
for pkg in bat fastfetch ghostty gitmux helix kitty nvim starship tmux zed zsh; do
    echo "--- $pkg ---"
    stow -nv --target="$HOME" "$pkg" 2>&1
done
```

Expected: each package prints lines like `LINK: .config/bat/config => ...dotfiles/bat/.config/bat/config` with no errors.

- [ ] **Step 2: Fix any conflicts before continuing**

If stow reports a conflict (e.g., a file already exists that isn't a symlink), remove or back up the conflicting file:

```bash
# Example — adjust path to match any actual conflict reported
mv ~/.config/helix ~/.config/helix.bak
```

Re-run the dry-run for that package until it reports no conflicts.

---

## Task 7: Apply Stow links

- [ ] **Step 1: Run install.sh**

```bash
~/.dotfiles/install.sh
```

Expected: each package prints `Stowing <pkg>...` followed by `Done.` with no errors.

- [ ] **Step 2: Verify symlinks were created**

```bash
ls -la ~/.config | grep '\->'
ls -la ~ | grep '\->' | grep -v steam
```

Expected: each package has a file-level symlink (e.g., `~/.config/bat/config -> ...dotfiles/bat/.config/bat/config`) instead of a directory-level one.

- [ ] **Step 3: Spot-check a config is readable by its app**

```bash
bat --version   # confirms bat config is found
starship --version  # confirms starship.toml is linked
```

---

## Task 8: Pull macOS platform differences from macbook branch

Review the files that differ between branches and create platform packages for anything that is genuinely macOS-specific (not just drifted).

**Files that differ** (already known from `git diff endeavour..macbook --name-only`):
`.zshrc`, `ghostty/config`, `helix/config.toml`, `helix/languages.toml`, `kitty/kitty.conf`, `starship.toml`, `tmux/tmux.conf`, `zed/keymap.json`, `zed/settings.json`, `aerospace.toml` (mac-only)

- [ ] **Step 1: Review each differing file**

For each file, compare the two versions:

```bash
# Example for ghostty config
git show macbook:ghostty/config
# Compare against current
cat ~/.dotfiles/ghostty/.config/ghostty/config
```

Repeat for: `.zshrc`, `helix/config.toml`, `helix/languages.toml`, `kitty/kitty.conf`, `starship.toml`, `tmux/tmux.conf`, `zed/keymap.json`, `zed/settings.json`.

- [ ] **Step 2: For each file — decide shared vs platform-specific**

- If the diff is just stale (Linux version is better/more recent): no action needed, macbook branch just needs to catch up.
- If the diff is genuinely platform-specific (e.g., macOS font names, Homebrew paths, macOS-only settings): extract it into a platform package.

Common candidates for platform-specific packages:
- `zsh-mac/` — macOS PATH exports (`/opt/homebrew/bin`, `Library/Python`, etc.)
- `ghostty-mac/` — if font or theme differs
- `zed-mac/` — if LSP paths or font settings differ

- [ ] **Step 3: Create the aerospace package (mac-only)**

```bash
cd ~/.dotfiles
mkdir -p aerospace/.config/aerospace
git show macbook:aerospace.toml > aerospace/.config/aerospace/aerospace.toml
git add aerospace/
git commit -m "feat: add aerospace stow package (macOS only)"
```

- [ ] **Step 4: Create any other platform packages identified in Step 2**

For each platform-specific file, create the appropriate package. Example for a mac-specific zsh config:

```bash
mkdir -p zsh-mac
# Extract only the mac-specific lines from macbook:.zshrc into zsh-mac/.zshrc-mac
# (or keep a full zsh-mac/.zshrc if the entire file differs)
git show macbook:.zshrc > zsh-mac/.zshrc
git add zsh-mac/
git commit -m "feat: add zsh-mac platform package"
```

Update `install.sh` PLATFORM array to include any new packages:

```bash
# In install.sh, update:
PLATFORM=(ghostty-mac aerospace zsh-mac)  # add whatever packages you created
```

- [ ] **Step 5: Commit install.sh update**

```bash
git add install.sh
git commit -m "chore: add platform packages to install.sh"
```

---

## Task 9: Merge to main and clean up branches

- [ ] **Step 1: Merge endeavour into main**

```bash
cd ~/.dotfiles
git checkout main
git merge endeavour
git push origin main
```

- [ ] **Step 2: Update README.md to reflect new structure**

Remove the branch-per-platform documentation and replace with a description of the new Stow-based approach. Key things to document:
- Run `./install.sh` to apply all symlinks
- Add new platform packages to `install.sh` PLATFORM array
- Put unused configs in `archive/`

```bash
git add README.md
git commit -m "docs: update README for stow-based structure"
git push origin main
```

- [ ] **Step 3: Delete stale branches (optional)**

Only do this once you're confident main is correct and fully working on both platforms.

```bash
git branch -d endeavour macbook
git push origin --delete macbook
git push origin --delete endeavour
```
