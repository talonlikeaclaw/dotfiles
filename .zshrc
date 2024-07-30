# Export paths
export PATH="$PATH:$HOME/.local/bin:/opt/homebrew/bin"
export ZSH="$HOME/.oh-my-zsh"

# Zsh History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Add Oh My Zsh plugins
plugins=(
  eza
  brew
  tmux
  ssh-agent
  dirhistory
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
  zsh-syntax-highlighting # Requires seperate install
)

# Configure eza using zstyle
zstyle ':omz:plugins:eza' dirs-first 'yes'
zstyle ':omz:plugins:eza' git-status 'yes'
zstyle ':omz:plugins:eza' header 'no'
zstyle ':omz:plugins:eza' show-group 'no'
zstyle ':omz:plugins:eza' time-style 'long-iso'
zstyle ':omz:plugins:eza' icons 'yes'

# Configure ssh-agent using zstyle
zstyle ':omz:plugins:ssh-agent' agent-forwarding 'yes'

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom aliases
alias c='clear'
alias cat='bat -p'
alias can='bat'
alias lg='lazygit'
alias n='clear ; neofetch'
alias music='psql -h 192.168.0.140 -U talon-likeaclaw -d music_db'
alias or='nvim ~/Documents/Obsidian/talons-brain/inbox/*.md'
alias size="du -sh"

# Clear screen and run neofetch at the end
clear
neofetch
