
# Interactive zsh configuration.
[[ -o interactive ]] || return 0

#####################
# SHELL ENVIRONMENT #
#####################
# zsh's path array is tied to PATH; keep the first occurrence of each entry.
typeset -gU path fpath
export GOPATH="${GOPATH:-$HOME/go}"
# Set base priority once; mise may prepend selected runtimes later.
if [[ -z ${_ZSHRC_PATH_INITIALIZED:-} ]]; then
    path=(
        "$HOME/.grok/bin"
        "$HOME/.cargo/bin"
        "$HOME/.bun/bin"
        "$HOME/.local/bin"
        "$GOPATH/bin"
        /opt/homebrew/bin
        /opt/homebrew/sbin
        "$HOME/bin"
        "${path[@]}"
    )
    typeset -g _ZSHRC_PATH_INITIALIZED=1
fi
export PATH

export EDITOR='nvim'
if [[ -x "$HOME/nvim-macos-arm64/bin/nvim" ]]; then
    export EDITOR="$HOME/nvim-macos-arm64/bin/nvim"
    alias nvim="$EDITOR"
elif (( ! $+commands[nvim] )); then
    export EDITOR='vi'
fi
export VISUAL="$EDITOR"
export PAGER='less'
if [[ "${EDITOR:t}" == nvim ]]; then
    export MANPAGER="${(q)EDITOR} +Man!"
else
    export MANPAGER="$PAGER"
fi
export LANG='en_US.UTF-8'
export EZA_CONFIG_DIR="$HOME/.config/eza"
export HOMEBREW_DOWNLOAD_CONCURRENCY='auto'

export ZLIB_DOMAIN=https://z-lib.gd
# Magpie
export OPENAI_BASE_URL='http://127.0.0.1:3425/v1'
export OPENAI_API_KEY='magpie'

# Preserve existing fzf options without appending duplicates on reload.
() {
    local opt
    local -a opts
    opts=(${(Z:n:)FZF_DEFAULT_OPTS})
    for opt in --highlight-line --info=inline-right --ansi --layout=reverse; do
        (( ${opts[(Ie)$opt]} )) || opts+=("$opt")
    done
    export FZF_DEFAULT_OPTS="${(j: :)opts}"
}

#####################
# PLUGIN MANAGER    #
#####################
typeset -g ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -r "$ZINIT_HOME/zinit.zsh" ]] && (( $+commands[git] )); then
    print -P '%F{220}Installing Zinit…%f'
    command mkdir -p "${ZINIT_HOME:h}" &&
        command chmod g-rwX "${ZINIT_HOME:h}" &&
        command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
if [[ -r "$ZINIT_HOME/zinit.zsh" ]] && (( ! $+functions[zinit] )); then
    source "$ZINIT_HOME/zinit.zsh"
fi

#####################
# COMPLETIONS       #
#####################
# Register every completion directory before compinit.
[[ -d "$HOME/.zfunc" ]] && fpath+=("$HOME/.zfunc")
[[ -d "$HOME/.grok/completions/zsh" ]] && fpath+=("$HOME/.grok/completions/zsh")
if (( $+functions[zinit] )) && [[ -z ${_ZSHRC_COMPLETIONS_LOADED:-} ]]; then
    zinit light zsh-users/zsh-completions
    typeset -g _ZSHRC_COMPLETIONS_LOADED=1
fi

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

if (( ! $+functions[compdef] )); then
    autoload -Uz compinit
    compinit -d "${ZDOTDIR:-$HOME}/.zcompdump-${ZSH_VERSION}"
fi
if (( $+functions[zinit] )); then
    autoload -Uz _zinit
    _comps[zinit]=_zinit
fi

# fzf-tab must follow compinit and precede widget-wrapping plugins.
if (( $+functions[zinit] && $+commands[fzf] )) && [[ -z ${_ZSHRC_FZF_TAB_LOADED:-} ]]; then
    zinit light Aloxaf/fzf-tab
    typeset -g _ZSHRC_FZF_TAB_LOADED=1
fi
if (( $+commands[eza] )); then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always -- "$realpath"'
else
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'command ls -1 -- "$realpath"'
fi
# Keep completion options separate from global fzf options that may break fzf-tab.
zstyle ':fzf-tab:*' use-fzf-default-opts no
zstyle ':fzf-tab:*' fzf-flags --highlight-line --info=inline-right --ansi --layout=reverse --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
if [[ -n ${TMUX:-} ]] && (( $+commands[tmux] )); then
    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
else
    zstyle ':fzf-tab:*' fzf-command fzf
fi

#####################
# SHELL INTEGRATION #
#####################
autoload -Uz add-zsh-hook
if (( $+commands[mise] && ! $+functions[_mise_hook] )); then
    eval "$(mise activate zsh)"
fi
if (( $+commands[zoxide] && ! $+functions[__zoxide_z] )); then
    eval "$(zoxide init --cmd cd zsh)"
fi

if (( $+functions[zinit] )) && [[ -z ${_ZSHRC_BASE_PLUGINS_LOADED:-} ]]; then
    zinit light zdharma-continuum/history-search-multi-word
    zinit light hlissner/zsh-autopair
    # Load before the first command so saved proxy settings apply immediately.
    zinit light SukkaW/zsh-proxy
    typeset -g _ZSHRC_BASE_PLUGINS_LOADED=1
fi
if (( $+commands[atuin] && ! $+functions[_atuin_preexec] )); then
    # Preserve the history fallback when Atuin precedes zsh-autosuggestions.
    (( ${+ZSH_AUTOSUGGEST_STRATEGY} )) || typeset -ga ZSH_AUTOSUGGEST_STRATEGY=(history)
    eval "$(atuin init zsh)"
fi
if (( $+commands[starship] && ! $+functions[prompt_starship_precmd] )); then
    eval "$(starship init zsh)"
fi

#####################
# ALIASES & HELPERS #
#####################
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
(( $+commands[python3] )) && alias python=python3
(( $+commands[bat] )) && alias cat=bat
if (( $+commands[eza] )); then
    alias ls='eza -a --color=always --icons=always --no-user'
    alias ll='eza -a --color=always -l --icons=always --no-user'
    alias la='eza --color=always --icons=always -a -l --octal-permissions --no-permissions'
    alias lt='eza --tree --color=always'
fi
alias zshconfig='"$EDITOR" "$HOME/.zshrc"'

# Ctrl-O inserts a shell-escaped directory and leaves the buffer intact on cancel.
function zoxide_fzf() {
    local dir
    dir=$(zoxide query --list | fzf --no-multi --no-preview) || return 0
    [[ -n "$dir" ]] || return 0
    LBUFFER+="${(q)dir}"
    zle reset-prompt
}
if (( $+commands[zoxide] && $+commands[fzf] )); then
    zle -N zoxide_fzf
    bindkey -M emacs '^O' zoxide_fzf
    bindkey -M viins '^O' zoxide_fzf
fi

# Atuin owns Ctrl-R; the existing multi-word search remains available on Alt-R.
if (( $+widgets[history-search-multi-word] )); then
    bindkey -M emacs '^[r' history-search-multi-word
    bindkey -M viins '^[r' history-search-multi-word
fi

function y() {
    local tmp cwd result
    tmp=$(mktemp -t yazi-cwd.XXXXXX) || return
    {
        command yazi "$@" --cwd-file="$tmp"
        result=$?
        IFS= read -r -d '' cwd < "$tmp"
        if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
            builtin cd -- "$cwd" || return
        fi
        return "$result"
    } always {
        command rm -f -- "$tmp"
    }
}

function zd() {
    local dir
    dir=$(zoxide query --list | fzf --no-multi --bind 'ctrl-j:down' --bind 'ctrl-k:up' --bind 'tab:down' --bind 'btab:up' --prompt='zoxide jump> ' --no-preview) || return 0
    [[ -n "$dir" ]] || return 0
    builtin cd -- "$dir"
}

function gw() {
    setopt localoptions pipefail
    local dir
    dir=$(command git worktree list --porcelain | command awk '/^worktree / { print substr($0, 10) }' | fzf --no-multi) || return
    [[ -n "$dir" ]] || return 0
    builtin cd -- "$dir"
}

#####################
# TERMINAL TITLE    #
#####################
function zsh_title_precmd() {
    [[ -t 1 && "$TERM" != dumb ]] || return 0
    local dir="${(%):-%~}"
    print -rn -- $'\e]0;'"${ZSH_NAME:t} | ${dir}"$'\a'
}

function zsh_title_preexec() {
    [[ -t 1 && "$TERM" != dumb ]] || return 0
    local dir="${(%):-%~}"
    local -a argv
    argv=(${(z)1})
    local process="${${(Q)argv[1]}:t}"
    print -rn -- $'\e]0;'"${ZSH_NAME:t} | ${process} | ${dir}"$'\a'
}
add-zsh-hook precmd zsh_title_precmd
add-zsh-hook preexec zsh_title_preexec

# Load widget wrappers last so they cover completion, history, and custom widgets.
if (( $+functions[zinit] )) && [[ -z ${_ZSHRC_WIDGET_PLUGINS_LOADED:-} ]]; then
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
    typeset -g _ZSHRC_WIDGET_PLUGINS_LOADED=1
fi
