### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


zinit light Aloxaf/fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light hlissner/zsh-autopair
# proxy
zinit ice wait'1' lucid
zinit light SukkaW/zsh-proxy

#####################
# COMPLETIONS       #
#####################
# load additional completions
fpath+=~/.zfunc
autoload -Uz compinit
compinit

#####################
# SHELL ENVIRONMENT #
#####################
export SHELL="/bin/zsh"
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'

export MANPAGER='nvim +Man!'
export LANG='en_US.UTF-8'
export EZA_CONFIG_DIR="~/.config/eza"
export PATH=$HOME/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export GOPATH=$HOME/go
export MANPATH="/usr/local/man:$MANPATH"
export HOMEBREW_DOWNLOAD_CONCURRENCY="auto"

# java home
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Python uv
export UV_PYTHON="3.13"

# Python pipx
export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Golang
[[ -v $GOPATH ]] && export PATH="$GOPATH/bin:$PATH"

# bob
export BOB_CONFIG="$HOME/.config/bob/config.json"

#####################
# FZF SETTINGS      #
#####################
#
# lagoon
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#1A283F,bg:#101825,spinner:#FFA0A0,hl:#1CA0FD \
# --color=fg:#D9E6FA,header:#F58888,info:#1CA0FD,pointer:#FFA0A0 \
# --color=marker:#FFA247,fg+:#D9E6FA,prompt:#1CA0FD,hl+:#FFAA00 \
# --color=selected-bg:#5A3824 \
# --color=border:#1CA0FD,label:#D9E6FA"
#
# night
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#262633,bg:#0D0D1A,spinner:#4AC8FF,hl:#D06666 \
# --color=fg:#E0E4F8,header:#F58888,info:#D06666,pointer:#4AC8FF \
# --color=marker:#FFA247,fg+:#E0E4F8,prompt:#D06666,hl+:#FFA247 \
# --color=selected-bg:#3E2F4A \
# --color=border:#D06666,label:#E0E4F8"
#
# desert
export FZF_DEFAULT_OPTS=" \
--color=bg+:#444444,bg:#333333,spinner:#87CEEB,hl:#D06666 \
--color=fg:#F7EDE1,header:#FFACA5,info:#D06666,pointer:#87CEEB \
--color=marker:#F0E68C,fg+:#F7EDE1,prompt:#D06666,hl+:#FFA852 \
--color=selected-bg:#335668 \
--color=border:#D06666,label:#F7EDE1"
#
# mirage
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#1A2D33,bg:#18252A,spinner:#C28EFF,hl:#5ABAAE \
# --color=fg:#DDEFEF,header:#F39493,info:#5ABAAE,pointer:#C28EFF \
# --color=marker:#FFA247,fg+:#DDEFEF,prompt:#5ABAAE,hl+:#FFA247 \
# --color=selected-bg:#5A3824 \
# --color=border:#5ABAAE,label:#DDEFEF"
#
#
#
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
"


# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias python=python3
alias cat=bat
# alias nvim=~/nvim-macos-arm64/bin/nvim
alias coding="tmuxinator start coding"

# # Eza
alias ls='eza -a --color=always --icons=always --no-user'
alias ll='eza -a --color=always -l --icons=always --no-user'
alias la='eza --color=always --icons=always -a -l --octal-permissions --no-permissions'
alias lt="eza --tree --color=always"

alias zshconfig="nvim ~/.zshrc"

eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(mise activate zsh)"

function zoxide_fzf() {
    LBUFFER+=$(zoxide query --list | fzf)
}
zle -N zoxide_fzf
bindkey '^o' zoxide_fzf

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# bun completions
[ -s "/Users/xuejingyi/.bun/_bun" ] && source "/Users/xuejingyi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
