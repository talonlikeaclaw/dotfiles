# Export paths
export PATH="$PATH:$HOME/.local/bin"
export PATH=/opt/cuda/bin:$PATH
export PATH="$HOME/.npm-global/bin:$PATH"

# Export environment variables
export ZSH="$HOME/.oh-my-zsh"
export CUDA_VISIBLE_DEVICES=0
export EDITOR=/usr/bin/nvim
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# Zsh History
HISTFILE=~/.zsh_history

# CONDITIONAL PLUGIN LOADING
if [[ -z "$CONTAINER_ID" ]]; then
    # Full plugin list for host
    plugins=(
      eza
      brew
      ssh-agent
      web-search
      zoxide
      starship
      zsh-autosuggestions
      copypath
      copyfile
      fzf
      you-should-use
      aliases
      colored-man-pages
      tmux
      zsh-syntax-highlighting
    )
else
    # Minimal plugins for containers
    plugins=(
      git
      aliases
      colored-man-pages
      copypath
      copyfile
    )
fi

# Configure tmux
# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_AUTOCONNECT=true
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
alias lg='lazygit'
alias n='clear ; fastfetch'
alias or='nvim ~/Documents/Obsidian/talons-brain/inbox/*.md'
alias py='python3'
alias size="du-sh"
alias td='tmux detach'
alias tn='tmux new-session -s '
alias ta='tmux attach -t '
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t '
alias r='ranger'
alias v='nvim'
alias szsh='source ~/.zshrc'
alias y='yazi'
alias h='helix'

# HOST-ONLY CONFIGURATION
if [[ -z "$CONTAINER_ID" ]]; then
    # Aliases that require host tools
    alias cat='bat -p'
    alias can='bat'
    alias gptoss='llama-server -m ~/.local/share/llama-models/unsloth/gpt-oss-20b-Q4_K_M.gguf -c 60000 --gpu-layers 999 --parallel 2 --batch-size 512 --host 127.0.0.1 --port 8080'
    
    # Initialize tools
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    
    # Clear screen and run fastfetch
    clear
    fastfetch
else
    # Container-friendly configuration
    alias cat='cat'

    # Simple prompt for containers
    PROMPT='%F{yellow}%~%f on %F{cyan}${CONTAINER_ID}%f %# '
fi
