#-------------------------------------------------------------------------------
# Environment Setup
#-------------------------------------------------------------------------------
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Starship config location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Lazygit config location
# export XDG_CONFIG_HOME=~/.config/

#-------------------------------------------------------------------------------
# Zinit Setup and Plugin Management
#-------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install zinit if not present
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light ajeetdsouza/zoxide

# Load Starship prompt
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Load Git plugin from Oh-My-Zsh
zinit snippet OMZP::git

#-------------------------------------------------------------------------------
# ZSH Options and Settings
#-------------------------------------------------------------------------------
# History settings
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Initialize completion system
autoload -Uz compinit && compinit
zinit cdreplay -q

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#-------------------------------------------------------------------------------
# Completion Settings
#-------------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always $realpath'

#-------------------------------------------------------------------------------
# Key Bindings
#-------------------------------------------------------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
# Navigation
# alias z='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# List files
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias ltr='eza --icons=auto --tree --level=2'
alias cat='bat'

# Git shortcuts
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Tmux
alias tmux='tmux -u'
alias t='tmux'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tn='tmux new-session -s'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'
alias tksv='tmux kill-server'

# Editors
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias hx='helix'
alias co='cursor'
alias coa='cursor .'

# Homebrew
alias un='brew uninstall'
alias up='brew update && brew upgrade'
alias pl='brew list'
alias pa='brew search'
alias pc='brew cleanup'
alias po='brew autoremove'

# System
alias cls='clear; fastfetch'
alias c='clear'
alias mkdir='mkdir -p'
alias df='df -h'
alias reload='source ~/.zshrc'
alias icat='kitty +kitten icat'
alias spt='spotify_player'
alias dep='vendor/bin/dep'

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias spotlightoff="sudo mdutil -a -i off"
alias spotlighton="sudo mdutil -a -i on"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash"

#-------------------------------------------------------------------------------
# Tool Initialization
#-------------------------------------------------------------------------------
# Display system information
fastfetch

# Initialize additional tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# Created by `pipx` on 2024-11-07 10:03:49
export PATH="$PATH:/Users/marbin/.local/bin"
export PATH="/Users/marbin/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/marbin/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export PATH=$PATH:/Users/marbin/.spicetify
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# Added by Antigravity
export PATH="/Users/marbin/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
