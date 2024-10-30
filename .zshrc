# Display system information
fastfetch

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Suppress instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Zinit installation and plugin management
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k # powerlevel10k

zinit light zsh-users/zsh-autosuggestions # zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting # zsh-syntax-highlighting
zinit light zsh-users/zsh-completions # zsh-completions
zinit light Aloxaf/fzf-tab # fzf-tab
zinit light ajeetdsouza/zoxide # zoxide


zinit snippet OMZP::git # oh-my-zsh git plugin

autoload -Uz compinit && compinit

zinit cdreplay -q

# Helpful aliases

# Misc
alias cls='clear; fastfetch'
alias c='clear'
alias spt='spotify_player'

# Change directory
alias z='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# List
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Homebrew
alias un='brew uninstall'
alias up='brew update && brew upgrade'
alias pl='brew list'
alias pa='brew search'
alias pc='brew cleanup'
alias po='brew autoremove'

# Tmux
alias tmux='tmux -u'
alias t='tmux'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tn='tmux new-session -s'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'
alias tksv='tmux kill-server'

# Vim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Git
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

# Misc
alias mkdir='mkdir -p'
alias df='df -h'
alias reload='source ~/.zshrc'
alias hx='helix'
alias icat='c; kitty +kitten icat'


# macOS specific aliases
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias spotlightoff="sudo mdutil -a -i off"
alias spotlighton="sudo mdutil -a -i on"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History configuration
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always $realpath'

# Initialize fzf and zoxide
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# Set default terminal
# export TERMINAL="/Applications/kitty.app/Contents/MacOS/kitty"
