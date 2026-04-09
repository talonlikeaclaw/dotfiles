#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS=$(uname)

SHARED=(bat fastfetch ghostty gitmux helix kitty nvim starship tmux)

if [[ "$OS" == "Darwin" ]]; then
    PLATFORM=(aerospace zed-mac zsh-mac)
elif [[ "$OS" == "Linux" ]]; then
    PLATFORM=(zed zsh)
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
