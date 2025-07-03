# ------------------------------
# ▶ PATH and ENV VARIABLES
# ------------------------------

set -Ux PATH $PATH $HOME/.local/bin
set -Ux DOTNET_ROOT /usr/local/share/dotnet
set -Ux PATH $DOTNET_ROOT $PATH
set -Ux EDITOR /usr/bin/nvim
set -Ux OLLAMA_HOST 0.0.0.0

# ------------------------------
# ▶ Starship prompt
# ------------------------------
starship init fish | source

# ------------------------------
# ▶ Zoxide smart directory jumping
# ------------------------------
zoxide init fish | source

# ------------------------------
# ▶ Aliases
# ------------------------------
alias c 'clear'
alias cat 'bat -p'
alias can 'bat'
alias lg 'lazygit'
alias n 'clear; fastfetch'
alias py 'python3'
alias size 'du -sh'
alias td 'tmux detach'
alias tn 'tmux new-session -s'
alias ta 'tmux attach -t'
alias tl 'tmux list-sessions'
alias tk 'tmux kill-session -t'
alias r 'ranger'
alias v 'nvim'
alias y 'yazi'

# ------------------------------
# ▶ Tmux Autostart
# ------------------------------
if status is-interactive
	set fish_greeting ""
	if not set -q TMUX
		tmux new-session -A -s mainframe \; send-keys "clear && fastfetch" C-m
	end
end
