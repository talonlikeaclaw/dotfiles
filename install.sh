#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS=$(uname)

SHARED=(bat fastfetch git ghostty gitmux helix herdr kitty nvim omp opencode starship television tmux)

if [[ "$OS" == "Darwin" ]]; then
    PLATFORM=(aerospace llama-swap-mac little-coder-mac wezterm-mac zed-mac zsh-mac)
elif [[ "$OS" == "Linux" ]]; then
    PLATFORM=(llama-swap niri noctalia wezterm zed zsh)
fi

cd "$DOTFILES"

# Bootstrap git submodules (e.g. TPM)
echo "Initializing submodules..."
git submodule update --init --recursive

for pkg in "${SHARED[@]}" "${PLATFORM[@]}"; do
    if [[ -d "$pkg" ]]; then
        echo "Stowing $pkg..."
        stow -R --target="$HOME" "$pkg"
    fi
done

echo "Done."
