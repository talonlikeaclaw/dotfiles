# Export paths
export PATH="$PATH:$HOME/.local/bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_ROOT="/usr/local/share/dotnet"
export PATH="$DOTNET_ROOT:$PATH"
export OLLAMA_HOST=0.0.0.0:11434
export CUDA_VISIBLE_DEVICES=0

# Zsh History
HISTFILE=~/.zsh_history

# Add Oh My Zsh plugins
plugins=(
  eza
  brew
  web-search
  zoxide
  starship
  zsh-autosuggestions # Requires seperate install
  copypath
  copyfile
  fzf
  you-should-use # Requires seperate install
  aliases
  colored-man-pages
  tmux
  zsh-syntax-highlighting # Requires seperate install
)

# Configure tmux
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_DEFAULT_SESSION_NAME="mainframe"

# Configure eza
zstyle ':omz:plugins:eza' dirs-first 'yes'
zstyle ':omz:plugins:eza' git-status 'yes'
zstyle ':omz:plugins:eza' header 'no'
zstyle ':omz:plugins:eza' show-group 'no'
zstyle ':omz:plugins:eza' time-style 'long-iso'
zstyle ':omz:plugins:eza' icons 'yes'

# Configure ssh-agent
zstyle ':omz:plugins:ssh-agent' agent-forwarding 'yes'

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom aliases
alias c='clear'
alias cat='bat -p'
alias can='bat'
alias lg='lazygit'
alias n='clear ; fastfetch'
alias or='nvim ~/Documents/Obsidian/talons-brain/inbox/*.md'
alias py='python3'
alias size="du -sh"
alias td='tmux detach'
alias tn='tmux new-session -s '
alias ta='tmux attach -t '
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t '
alias r='ranger'
alias v='nvim'
alias sh='history | fzf'
alias szsh='source ~/.zshrc'
alias y='yazi'
alias h='helix'

# Intialize tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Clear screen and run neofetch at the end
clear
fastfetch
