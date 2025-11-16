
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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait'0a' lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
# Then load url-quote-magic and bracketed-paste-magic as above
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
# Now the fix, setup these two hooks:
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# and finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete bracketed-paste accept-line push-line-or-edit)
# ENHANCD
zinit ice wait'0b' lucid
zinit light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco

# HISTORY SUBSTRING SEARCHING
zinit ice wait'0b' lucid atload'!export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=black,bold"'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# TAB COMPLETIONS
zinit light-mode for \
    blockf \
        zsh-users/zsh-completions \
    as'program' atclone'rm -f ^(rgg|agv)' \
        lilydjwg/search-and-view \
    src'etc/git-extras-completion.zsh' \
        tj/git-extras
zinit wait'1' lucid for \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:*' query-string prefix first
# zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --no-quotes -1 --color=always $realpath'  # disable for tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 0 0
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:eza' file-sort modification
zstyle ':completion:*:eza' sort false
# TMUX plugin manager
zinit ice lucid wait'!0a' as'null' id-as'tpm' \
  atclone' \
    mkdir -p $HOME/.tmux/plugins; \
    ln -s $HOME/.zinit/plugins/tpm $HOME/.tmux/plugins/tpm; \
    setup_my_tmux_plugin tpm;'
zinit light tmux-plugins/tpm
# FZF TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as'command' pick'bin/fzf-tmux'
zinit light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc'shell/{completion,key-bindings}.zsh' id-as'junegunn/fzf_completions' pick'/dev/null'
zinit light junegunn/fzf
# FZF-TAB
zinit ice wait'1' lucid
zinit light Aloxaf/fzf-tab
# SYNTAX HIGHLIGHTING
zinit ice wait'0c' lucid
zinit light zdharma-continuum/fast-syntax-highlighting
# ZSH AUTOPAIRS
zinit ice wait'0c' lucid
zinit light hlissner/zsh-autopair
# FORGIT
zinit ice wait lucid id-as'forgit' atload'alias gr=forgit::checkout::file'
zinit load 'wfxr/forgit'
# FORYADM
zinit ice wait lucid id-as'foryadm'
zinit load 'disrupted/foryadm'
# cheat.sh
zinit wait'2a' lucid \
  id-as'cht.sh' \
  as'program' \
  for https://cht.sh/:cht.sh
  # has'rlwrap' \
zinit wait'2b' lucid \
  id-as'cht-completion' \
  has'rlwrap' \
  mv'cht* -> _cht' \
  as'completion' \
  for https://cheat.sh/:zsh
# mmv renamer
zinit ice lucid wait'0' as'program' id-as'mmv' from'gh-r' \
  mv'mmv* -> mmv' pick'mmv/mmv'
zinit light 'itchyny/mmv'
# python automatic virtualenv
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

# quickenv (direnv replacement)
zinit ice lucid wait'0' as'program' id-as'quickenv' from'gh-r' \
  mv'quickenv* -> quickenv' pick'quickenv'
zinit light 'untitaker/quickenv'

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zhistory"
HISTSIZE=290000
SAVEHIST=$HISTSIZE

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt sharehistory           # global history
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt hash_list_all          # hash everything before completion
setopt completealiases        # complete alisases
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect              # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
setopt interactivecomments    # recognize comments

export QUOTING_STYLE=literal  # ls: do not wrap in single quotes
chpwd() {
  if [[ $(ls | wc -l) -ge 20 ]]; then
    # print as grid
    eza --no-quotes -G -a -F --icons --group-directories-first --git --color=always --ignore-glob=".DS_Store|__*"
  else
    # print as list and add left padding
    eza --no-quotes -1 -a -F --icons --group-directories-first --git --color=always --ignore-glob=".DS_Store|__*" | sed 's/^/  /'
  fi
}
#####################
# HOMEBREW          #
#####################
export PATH="/opt/homebrew/bin:$PATH"
if type brew &>/dev/null; then
    export HOMEBREW_HOME=$(brew --prefix)
    export HOMEBREW_CASK_OPTS=--no-quarantine
    export PATH="$HOMEBREW_HOME/bin:$PATH"
    export PATH="$HOMEBREW_HOME/sbin:$PATH"
    export SHELL="$HOMEBREW_HOME/bin/zsh"

    # completions
    FPATH="$HOMEBREW_HOME/share/zsh/site-functions:$FPATH"

    # LLVM (C, C++)
    export PATH="$HOMEBREW_HOME/opt/llvm/bin:$PATH"

    # # Java runtime
    # export PATH="$HOMEBREW_HOME/opt/openjdk/bin:$PATH"

    # For compilers and pkgconfig to find zlib, bzip2, llvm (c, cpp), FreeTDS (PyMSSQL)
    export LDFLAGS="-L$HOMEBREW_HOME/opt/zlib/lib -L$HOMEBREW_HOME/opt/bzip2/lib -L$HOMEBREW_HOME/opt/llvm/lib -Wl,-rpath,$HOMEBREW_HOME/opt/llvm/lib -L$HOMEBREW_HOME/opt/freetds/lib -L$HOMEBREW_HOME/opt/openssl@3/lib"
    export CFLAGS="-I$HOMEBREW_HOME/opt/freetds/include"
    export CPPFLAGS="-I$HOMEBREW_HOME/opt/zlib/include -I$HOMEBREW_HOME/opt/bzip2/include -I$HOMEBREW_HOME/opt/llvm/include -I$HOMEBREW_HOME/opt/openssl@3/include"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $HOMEBREW_HOME/opt/zlib/lib/pkgconfig"
    export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/opt/homebrew/lib"
fi
#####################
# SHELL ENVIRONMENT #
#####################
# export TERM=xterm-256color
# export TERMINAL='kitty'
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4 -~ --mouse'
export LESS_TERMCAP_mb=$'\E[6m'     # begin blinking
export LESS_TERMCAP_md=$'\E[34m'    # begin bold
export LESS_TERMCAP_us=$'\E[4;32m'  # begin underline
export LESS_TERMCAP_so=$'\E[0m'     # begin standout-mode (info box), remove background
export LESS_TERMCAP_me=$'\E[0m'     # end mode
export LESS_TERMCAP_ue=$'\E[0m'     # end underline
export LESS_TERMCAP_se=$'\E[0m'     # end standout-mode
export MANPAGER='nvim +Man!'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'  # sane moving between words on the prompt
export PROMPT_EOL_MARK=''  # hide % at end of output
export GPG_TTY=$(tty)

export SHELL="/bin/zsh"
export EZA_CONFIG_DIR="~/.config/eza"
export PATH=$HOME/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export GOPATH=$HOME/go
export MANPATH="/usr/local/man:$MANPATH"
export HOMEBREW_DOWNLOAD_CONCURRENCY="auto"

# Python uv
export UV_PYTHON="3.13"

# Python pipx
export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Golang
[[ -v $GOPATH ]] && export PATH="$GOPATH/bin:$PATH"

#####################
# COMPLETIONS       #
#####################
# load additional completions
fpath+=~/.zfunc
autoload -Uz compinit
compinit

#####################
# COLORING          #
#####################
autoload colors && colors

#####################
# FZF SETTINGS      #
#####################
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=header {} 2>/dev/null" --preview-window=right:60%:wrap'
export FZF_ALT_C_COMMAND='fd -t d -d 1'
export FZF_ALT_C_OPTS='--preview="eza --no-quotes -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
"

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship


# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias python=python3
alias cat=bat
alias nvim=~/nvim-macos-arm64/bin/nvim
alias coding="tmuxinator start coding"

# # Eza
alias ls='eza --color=always --icons=always --no-user'
alias ll='eza --color=always -l --icons=always --no-user'
alias la='eza --color=always --icons=always -a -l --octal-permissions --no-permissions'
alias lt="eza --tree --color=always"

alias zshconfig="nvim ~/.zshrc"

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

