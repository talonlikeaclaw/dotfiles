export PATH="$PATH:$HOME/.local/bin:/opt/homebrew/bin"
export ZSH="$HOME/.oh-my-zsh"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Add Oh My Zsh plugins
plugins=(
  git
  zoxide
  starship
  zsh-autosuggestions
  copypath
  copyfile
  fzf
  you-should-use
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias ls='eza -l --color=always --group-directories-first'
alias cat='bat -p'
alias can='bat'
alias lg='lazygit'
alias n='clear ; neofetch'
alias jinit='mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false'
alias music='psql -h 192.168.0.140 -U talon-likeaclaw -d music_db'
alias or='nvim ~/Documents/Obsidian/talons-brain/inbox/*.md'
alias ts='tmux ls'
alias tc="tmux a -t"
alias tn="tmux new -s"
alias size="du -sh"
alias tk="tmux kill-session -t"
alias agent='eval $(ssh-agent) ; ssh-add ~/.ssh/id_ed25519'

# Clear screen and run neofetch at the end
clear
neofetch
